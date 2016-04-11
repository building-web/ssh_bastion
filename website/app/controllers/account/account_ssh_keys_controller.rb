class Account::AccountSshKeysController < Account::BaseController
  def index
    @account_ssh_keys = current_account.ssh_keys.page(params[:page])

    @account_ssh_key = AccountSshKey.new
  end

  def create
    @account_ssh_key = current_account.ssh_keys.new(ssh_key_params)
    if @account_ssh_key.save
      redirect_to account_account_ssh_keys_path, notice: t('flash.actions.create.notice', resource_name: 'Ssh key')
    else

      @account_ssh_keys = current_account.ssh_keys.page(params[:page])

      render :index
    end
  end

  def destroy
    @account_ssh_key = current_account.ssh_keys.find(params[:id])
    if @account_ssh_key.destroy
      redirect_to account_account_ssh_keys_path, notice: t('flash.actions.destroy.notice', resource_name: 'Ssh key')
    else
      @account_ssh_keys = current_account.ssh_keys.page(params[:page])

      render :index
    end
  end

  private

  def ssh_key_params
    params.require(:account_ssh_key).permit(
      :title, :key
    )
  end
end
