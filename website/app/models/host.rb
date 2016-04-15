class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  has_many :assigned_hosts, dependent: :destroy

  validates :ip, ip: { format: :v4 }, uniqueness: true
  validate :users_presence_more_than_one
  validate :user1_valid
  validate :user2_valid
  validate :user3_valid

  after_save :sync_user_to_assigned_hosts, on: :update

  private
  def users_presence_more_than_one
    if user1.blank? and user2.blank? and user3.blank?
      errors.add :user1, 'users must be more than one'
    end
  end

  def user1_valid
    return errors.add :user1, :invalid if user1 == 'root'
  end

  def user2_valid
    return errors.add :user2, :invalid if user2 == 'root'
  end

  def user3_valid
    return errors.add :user3, :invalid if user3 == 'root'
  end

  def sync_user_to_assigned_hosts
    begin
      assigned_hosts.find_each do |assigned_host|
        assigned_host.user1 = user1 if assigned_host.user1.present?
        assigned_host.user2 = user2 if assigned_host.user2.present?
        assigned_host.user2 = user2 if assigned_host.user3.present?
        assigned_host.save!
      end
    rescue err
      logger.errorerr.message
    end
  end
end
