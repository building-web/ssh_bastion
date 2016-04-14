class CreateBastionHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :bastion_hosts do |t|
      t.integer :arch_mode, default: 1
      t.string :ip
      t.string :user
      t.string :desc
      t.text :ssh_public_key

      t.timestamps
    end
  end
end
