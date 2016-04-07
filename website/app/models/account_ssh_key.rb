class AccountSshKey < ApplicationRecord

  extend Enumerize

  CAT_ARRAY = [
    :'ssh-rsa',
    :'ssh-dsa',
  ]

  enumerize :cat, in: CAT_ARRAY

  belongs_to :account

  validates :content, uniqueness: { case_sensitive: true }

end
