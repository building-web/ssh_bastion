class CreateHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :hosts do |t|
      t.integer :creator_account_id
      t.belongs_to :bastion_host, foreign_key: true

      t.string :ip
      t.integer :port

      t.string :code
      t.string :comment

      t.string :user1
      t.string :user2
      t.string :user3

      t.timestamps
    end

    add_index :hosts, :creator_account_id
  end
end
