class CreateAccountsHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts_hosts do |t|
      t.belongs_to :account, foreign_key: true
      t.belongs_to :bastion_host, foreign_key: true
      t.string :host_user

      t.timestamps
    end
  end
end
