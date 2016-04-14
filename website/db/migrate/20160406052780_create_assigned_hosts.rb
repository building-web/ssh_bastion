class CreateAssignedHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :assigned_hosts do |t|
      t.belongs_to :account, foreign_key: true
      t.belongs_to :host, foreign_key: true
      t.string :mark
      t.string :user1
      t.string :user2
      t.string :user3

      t.timestamps
    end
  end
end
