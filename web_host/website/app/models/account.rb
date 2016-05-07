class Account < ApplicationRecord

  extend Enumerize

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  # :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable,
         :two_factor_authenticatable,
         :two_factor_backupable,
         otp_secret_encryption_key: Settings.devise_two_factor_otp_secret_encryption_key,
         otp_backup_code_length: 6,
         otp_number_of_backup_codes: 10

  # https://github.com/attr-encrypt3d/attr_encrypted/blob/8800a289e2fef694647255d2e07b0a2aa1b5260b/lib/attr_encrypted.rb#L47
  # https://github.com/tinfoil/devise-two-factor/blob/devise-4/lib/devise_two_factor/models/two_factor_authenticatable.rb#L12
  # fix "Mysql2::Error: Incorrect string value: '\xDD\xFB\xD8<6\xE8...' for column 'encrypted_otp_secret'"
  attr_encrypted :otp_secret,
                  key:       Settings.devise_two_factor_otp_secret_encryption_key,
                  mode:      :per_attribute_iv_and_salt,
                  algorithm: 'aes-256-cbc',
                  default_encoding: 'm',
                  encode: true,
                  encode_iv: true,
                  encode_salt: true


  has_many :ssh_keys, class_name: 'AccountSshKey', foreign_key: :public_key_boxable_id, dependent: :destroy
  has_many :hosts, class_name: 'Host', foreign_key: :creator_account_id, dependent: :destroy

  has_many :assigned_hosts, dependent: :destroy

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

  def has_ssh_key?
    ssh_keys.count > 0
  end

  def enabled_two_factor_authentication?
    !otp_secret.nil? and !consumed_timestep.nil?
  end

  def secret_matched?
    has_ssh_key? and enabled_two_factor_authentication?
  end


  def activate_two_factor otp_attempt
    if self.validate_and_consume_otp!(otp_attempt)
      self.generate_otp_backup_codes!
      self.save
    else
      errors.add :otp_attempt, 'Otp attempt is not match, please input agian'
      return false
    end
  end

  def qr_code
    qrcode = RQRCode::QRCode.new(two_factor_otp_url)

    png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 248,
          border_modules: 4,
          module_px_size: 6,
          file: nil # path to write
          )
    png.to_data_url
  end

  private

  def two_factor_otp_url
   "otpauth://totp/%{app_id}?secret=%{secret}&issuer=%{app}" % {
      :secret => otp_secret,
      :app    => "SSH_Bash_Host",
      :app_id => email
    }
  end
end
