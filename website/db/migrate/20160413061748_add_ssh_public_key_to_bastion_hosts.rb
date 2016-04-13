class AddSshPublicKeyToBastionHosts < ActiveRecord::Migration[5.0]
  def change
    add_column :bastion_hosts, :ssh_public_key, :text
  end
end
