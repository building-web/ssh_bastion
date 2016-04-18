class Account::TwoFactorAuthenticationsController < Account::BaseController
  def show
  end

  def new
    current_account.otp_secret ||= Account.generate_otp_secret
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
    current_account.otp_secret = Account.generate_otp_secret
    current_account.otp_required_for_login = false
    current_account.save!
  end

  def destroy
    current_account.otp_required_for_login = false
    current_account.consumed_timestep = nil
    current_account.otp_secret = nil
    current_account.save!

    redirect_to account_two_factor_authentication_path, notice: t('flash.actions.destroy.notice', resource_name: 'Two-factor authentication')
  end

  private
  def account_params
    params.require(:account).permit(:otp_attempt)
  end
end
