class User < ApplicationRecord
  attr_encrypted :otp_secret,
      :key       => ENV['TWO_STEP_ENCRYPTION_KEY'],
      :mode      => :per_attribute_iv_and_salt,
      :algorithm => 'aes-256-cbc'

  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['TWO_STEP_ENCRYPTION_KEY']
end
