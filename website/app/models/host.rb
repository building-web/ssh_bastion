class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'
  has_one :host_user_app, class_name: 'HostUser'
  accepts_nested_attributes_for :host_user_app

  has_one :host_user_dev, class_name: 'HostUser'
  accepts_nested_attributes_for :host_user_dev

  validates :ip, ip: { format: :v4 }
  # TODO host_user_dev host_user_app not eq  and not eq root
end
