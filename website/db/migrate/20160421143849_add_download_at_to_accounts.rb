class AddDownloadAtToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :downloaded_at, :datetime
  end
end
