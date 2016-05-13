class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  belongs_to :bastion_host
  has_many :assigned_hosts, dependent: :destroy

  validates :ip, presence: true, uniqueness: {scope: :bastion_host_id}, ip: { format: :v4 }
  validates :port, presence: true
  validates :user1, exclusion: {in: %w(root)}, allow_nil: true
  validates :user2, exclusion: {in: %w(root)}, allow_nil: true
  validates :user3, exclusion: {in: %w(root)}, allow_nil: true

  validate :check_userx

  after_save :sync_user_to_assigned_hosts, on: :update

  def self.build_default
    remote_host_hash = Settings.remote_host.to_h
    return if remote_host_hash.blank?

    ip = remote_host_hash[:ip]
    port = remote_host_hash[:port]
    user = remote_host_hash[:user]

    host = Host.find_or_initialize_by(ip: ip)
    host.creator_account = Account.first
    host.attributes = {port: port, user1: user}

    host.save!
  end

  private

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
      Rails.logger.error err.message
    end
  end
end
