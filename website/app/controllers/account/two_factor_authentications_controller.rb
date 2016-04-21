class Account::TwoFactorAuthenticationsController < Account::BaseController
  def show
  end

  def new
    authorize current_account, :new?

    current_account.otp_secret ||= Account.generate_otp_secret(10)
    current_account.save!
  end

  def create
    if current_account.activate_two_factor(account_params[:otp_attempt])
      redirect_to account_two_factor_authentication_path, notice: t('flash.actions.create.notice', resource_name: 'Two-factor authentication')
    else
      render :new
    end
  end

  def reset
  end

  def recovery_codes
    authorize current_account, :recovery_codes?
    current_account.touch(:download_at)
    send_data current_account.otp_backup_codes, filename: 'recovery_codes.txt'
  end

  private
  def account_params
    params.require(:account).permit(:otp_attempt)
  end
end
