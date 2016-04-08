class Account < ApplicationRecord

  extend Enumerize

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  # :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: Settings.two_step_encryption_key

  # https://github.com/attr-encrypted/attr_encrypted/blob/8800a289e2fef694647255d2e07b0a2aa1b5260b/lib/attr_encrypted.rb#L47
  # https://github.com/tinfoil/devise-two-factor/blob/devise-4/lib/devise_two_factor/models/two_factor_authenticatable.rb#L12
  # fix "Mysql2::Error: Incorrect string value: '\xDD\xFB\xD8<6\xE8...' for column 'encrypted_otp_secret'"
  attr_encrypted :otp_secret,
                  key:       Settings.two_step_encryption_key,
                  mode:      :per_attribute_iv_and_salt,
                  algorithm: 'aes-256-cbc',
                  default_encoding: 'm',
                  encode: true,
                  encode_iv: true,
                  encode_salt: true


  has_many :ssh_keys, class_name: 'AccountSshKey'


  ROLE_HASH = {
    user: 1,
    admin: 9,
  }

  enumerize :role, in: ROLE_HASH,
                    default: :user,
                    i18n_scope: "enums.account.role",
                    scope: true,
                    predicates: { prefix: true }

  def role?(_role)
    send("role_#{_role}?")
  end

  def submitted_ssh_key?
    ssh_keys.count > 0
  end

  def enabled_two_factor_authentication?
    !otp_secret.nil? and !consumed_timestep.nil?
  end

end
