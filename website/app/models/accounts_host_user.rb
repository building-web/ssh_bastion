class AccountsHostUser < ApplicationRecord
  belongs_to :account
  belongs_to :bastion_host
end
