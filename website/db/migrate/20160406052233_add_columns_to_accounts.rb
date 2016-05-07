class AddColumnsToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :role, :integer, default: 1

    add_column :accounts, :otp_backup_codes_downloaded_at, :datetime
  end
end
