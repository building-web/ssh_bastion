class AccountsHostUser < ApplicationRecord
  belongs_to :account
  belongs_to :host
  belongs_to :host_user
end
