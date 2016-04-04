class Account < ApplicationRecord

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

end
