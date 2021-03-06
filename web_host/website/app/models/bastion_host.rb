class BastionHost < ApplicationRecord

  has_one :ssh_key, ->{ with_cat(:ssh) }, class_name: 'PublicKeyBox', as: :public_key_boxable
  has_one :gpg_key, ->{ with_cat(:gpg) }, class_name: 'PublicKeyBox', as: :public_key_boxable


  validates :ip, presence: true, uniqueness: true, ip: { format: :v4 }
  validates :port, presence: true
  validates :user, presence: true

  accepts_nested_attributes_for :ssh_key, reject_if: :all_blank, allow_destroy: true
  validates_associated :ssh_key

  accepts_nested_attributes_for :gpg_key, reject_if: :all_blank, allow_destroy: true
  validates_associated :gpg_key

  def self.build_default
    bastion_host_hash = Settings.bastion_host.to_h
    return if bastion_host_hash.blank?

    ip = bastion_host_hash[:ip]
    port = bastion_host_hash[:port]
    user = bastion_host_hash[:user]

    gpg_key_pub_asc = bastion_host_hash[:gpg_key][:public_asc]
    gpg_key_id = bastion_host_hash[:gpg_key][:id]

    local_gpg_keys = GPGME::Key.find(:secret, gpg_key_id)
    if local_gpg_keys.blank?
      gpg_key_pub_asc = File.read(Rails.root.join("spec/data/gpg_keys/#{gpg_key_id}.key.pub_asc").to_s)
      gpg_key_priv_asc = File.read(Rails.root.join("spec/data/gpg_keys/#{gpg_key_id}.key.priv_asc").to_s)

      GPGME::Key.import(gpg_key_pub_asc)
      GPGME::Key.import(gpg_key_priv_asc)
    end

    ssh_key_public = bastion_host_hash[:ssh_key][:public]

    bastion_host = BastionHost.find_or_initialize_by(ip: ip)
    bastion_host.attributes = {port: port, user: user}

    bastion_host.ssh_key_attributes = {key: ssh_key_public, title: 'SSH key'}
    bastion_host.gpg_key_attributes = {key: gpg_key_pub_asc, title: 'GPG key', key_id: gpg_key_id}

    bastion_host.save!

  end

end
