class Account::TwoFactorAuthenticationsController < Account::BaseController
  def show
  end

  def new
    current_account.otp_secret ||= Account.generate_otp_secret
    current_account.save!

    @qr = RQRCode::QRCode.new(current_account.two_factor_otp_url).to_img.resize(240, 240).to_data_url
  end

  def create
    if current_account.validate_and_consume_otp!(account_params[:otp_attempt])
      current_account.otp_required_for_login = true
      current_account.generate_otp_backup_codes!
      current_account.save!
      redirect_to account_two_factor_authentication_path, notice: t('flash.account.two_factor_authentications.create.notice')
    else
      render :new
    end
  end

  def reset
    current_account.otp_secret = Account.generate_otp_secret
    current_account.save!

    @qr = RQRCode::QRCode.new(current_account.two_factor_otp_url).to_img.resize(240, 240).to_data_url
  end

  def destroy
    current_account.otp_required_for_login = true
    current_account.save!
    redirect_to account_two_factor_authentication_path
  end

  private
  def account_params
    params.require(:account).perimit(:otp_attempt)
  end
end
