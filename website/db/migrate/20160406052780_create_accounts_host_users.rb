class CreateAccountsHostUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts_host_users do |t|
      t.belongs_to :account, foreign_key: true
      t.belongs_to :host, foreign_key: true
      t.belongs_to :host_user, foreign_key: true

      t.timestamps
    end
  end
end
