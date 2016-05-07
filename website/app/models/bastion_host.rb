class BastionHost < ApplicationRecord

  validates :ip, ip: { format: :v4 }

  has_one :ssh_key, ->{ with_cat(:ssh) }, class_name: 'PublicKeyBox', as: :public_key_boxable

  has_one :gpg_key, ->{ with_cat(:gpg) }, class_name: 'PublicKeyBox', as: :public_key_boxable


  accepts_nested_attributes_for :ssh_key, reject_if: :all_blank, allow_destroy: true
  validates_associated :ssh_key

  accepts_nested_attributes_for :gpg_key, reject_if: :all_blank, allow_destroy: true
  validates_associated :gpg_key

  def self.build_default
    bastion_host_hash = Settings.bastion_host.to_h
    return if bastion_host_hash.blank?

    ip = bastion_host_hash[:ip]
    user = bastion_host_hash[:user]
    gpg_key_public_asc = bastion_host_hash[:gpg_key][:public_asc]
    gpg_key_id = bastion_host_hash[:gpg_key][:id]
    ssh_key_public = bastion_host_hash[:ssh_key][:public]

    bastion_host = BastionHost.find_or_initialize_by(ip: ip)
    bastion_host.attributes = {user: user}

    bastion_host.ssh_key_attributes = {key: ssh_key_public, title: 'SSH key'}
    bastion_host.gpg_key_attributes = {key: gpg_key_public_asc, title: 'GPG key', key_id: gpg_key_id}

    bastion_host.save!

  end

end
