class Host < ApplicationRecord

  belongs_to :creator_account, class_name: 'Account', foreign_key: 'creator_account_id'

  validates :ip, :ip => { :format => :v4 }

end
