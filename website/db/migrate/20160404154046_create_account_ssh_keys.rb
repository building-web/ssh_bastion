class CreateAccountSshKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :account_ssh_keys do |t|
      t.belongs_to :account, foreign_key: true
      t.string :key_type
      t.text :public_key
      t.string :comment

      t.timestamps
    end
  end
end
