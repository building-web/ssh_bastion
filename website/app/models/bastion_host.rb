class BastionHost < ApplicationRecord

  validates :ip, ip: { format: :v4 }

  has_one :ssh_key, class_name: 'PublicKeyBox', as: :public_key_boxable

  accepts_nested_attributes_for :ssh_key, reject_if: :all_blank, allow_destroy: true
  validates_associated :ssh_key

  def self.build_default
    case Settings.Arch_mode.to_i
    when 1
      arch_mode = 1
      ip = '127.0.0.1'
      attrs = Settings.Arch_mode_1st.to_h

      bastion_host = BastionHost.find_or_initialize_by(arch_mode: arch_mode, ip: ip)
      bastion_host.attributes = attrs.slice(:user)

      bastion_host.ssh_key_attributes = {key: attrs[:ssh_public_key], title: 'key'}
      bastion_host.save!
    end
  end

end
