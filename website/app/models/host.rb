class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  has_many :assigned_hosts, dependent: :destroy

  validates :ip, ip: { format: :v4 }, uniqueness: true
  validate :check_userx
  validate :user1_valid
  validate :user2_valid
  validate :user3_valid

  after_save :sync_user_to_assigned_hosts, on: :update

  private
  def user1_valid
    return errors.add :user1, :invalid if user1 == 'root'
  end

  def user2_valid
    return errors.add :user2, :invalid if user2 == 'root'
  end

  def user3_valid
    return errors.add :user3, :invalid if user3 == 'root'
  end

  def check_userx
     userx = [user1, user2, user3].reject{|x| x.blank?}

     if userx.blank?
       errors.add :base, 'users must be more than one.'
     end

    if userx.uniq.size != userx.size
       errors.add :base, :taken
    end
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
