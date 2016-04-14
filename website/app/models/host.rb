class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'

  has_many :host_users, dependent: :destroy
  validates_associated :host_users
  accepts_nested_attributes_for :host_users

  has_many :accounts_host_users, dependent: :destroy
  has_many :assigned_accounts, through: :accounts_host_users, source: :account

  validates :ip, ip: { format: :v4 }, uniqueness: true
  validates :host_users, nested_attributes_uniqueness: {field: :name}
end
