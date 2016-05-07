class CreateBastionHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :bastion_hosts do |t|
      t.string :ip
      t.string :user
      t.string :desc

      t.timestamps
    end
  end
end
