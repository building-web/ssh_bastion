class AddColumnsToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :role, :integer, default: 1
  end
end
