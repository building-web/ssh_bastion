class AccountsSshKey < ApplicationRecord
  belongs_to :account
  validates :public_key, uniqueness: { case_sensitive: true }
end
