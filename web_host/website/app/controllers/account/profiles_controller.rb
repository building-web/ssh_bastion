class Account::ProfilesController < Account::BaseController

  before_action :set_account

  def show
  end

  def update_password
    if @account.update_with_password(account_params_with_update_password)
      sign_in(@account, bypass: true)
      redirect_to account_root_path, notice: t('flash.account.profiles.update_password.notice')
    else
      render :show
    end
  end

  private

  def set_account
    @account = current_account
  end

  def account_params_with_update_password
    params[:account] ||= {_: 0}

    params.require(:account).permit(
      :current_password, :password, :password_confirmation
    )
  end

end
