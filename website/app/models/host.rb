class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  has_many :assigned_hosts, dependent: :destroy

  validates :ip, ip: { format: :v4 }, uniqueness: true
  validates :user1, presence: true
  validate :check_users_not_root

  private
  def check_users_not_root
    return errors.add :user1, :invalid if user1 == 'root'
    return errors.add :user2, :invalid if user2 == 'root'
    return errors.add :user3, :invalid if user3 == 'root'
  end
end
