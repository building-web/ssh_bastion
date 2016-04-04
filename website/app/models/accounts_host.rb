class AccountsHost < ApplicationRecord
  belongs_to :account
  belongs_to :bash_host
end
