class AccountSshKey < PublicKeyBox

  default_value_for :public_key_boxable_type, 'Account'

  belongs_to :account, class_name: 'Account', foreign_key: 'public_key_boxable_id'
end
