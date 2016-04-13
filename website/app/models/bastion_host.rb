class BastionHost < ApplicationRecord

  validates :ip, ip: { format: :v4 }

  def self.build_default
    case Settings.Arch_mode.to_i
    when 1
      arch_mode = 1
      ip = '127.0.0.1'
      attrs = Settings.Arch_mode_1st.to_h

      bastion_host = BastionHost.find_or_initialize_by(arch_mode: arch_mode, ip: ip)
      bastion_host.attributes = attrs.slice(:user, :ssh_public_key)
      bastion_host.save!
    end
  end

end
