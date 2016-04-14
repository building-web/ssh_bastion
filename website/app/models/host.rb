class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  has_many :assigned_accounts, dependent: :destroy

  validates :ip, ip: { format: :v4 }, uniqueness: true
end
