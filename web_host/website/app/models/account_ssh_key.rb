class AccountSshKey < PublicKeyBox

  attribute :public_key_boxable_type, :string, default: -> { 'Account' }

  belongs_to :account, class_name: 'Account', foreign_key: 'public_key_boxable_id'
end
