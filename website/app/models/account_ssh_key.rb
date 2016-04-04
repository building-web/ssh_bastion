class AccountSshKey < ApplicationRecord
  belongs_to :account
  validates :key, uniqueness: { case_sensitive: true }
end
