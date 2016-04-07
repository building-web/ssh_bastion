class Account < ApplicationRecord

  extend Enumerize

  attr_encrypted :otp_secret,
                  key:       ENV['TWO_STEP_ENCRYPTION_KEY'],
                  mode:      :per_attribute_iv_and_salt,
                  algorithm: 'aes-256-cbc'


  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  # :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['TWO_STEP_ENCRYPTION_KEY']



  ROLE_HASH = {
    user: 1,
    admin: 9,
  }

  enumerize :role, in: ROLE_HASH,
                    default: :user,
                    i18n_scope: "enums.account.role",
                    scope: true,
                    predicates: { prefix: true }

end
