class AddDownloadAtToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :download_at, :datetime
  end
end
