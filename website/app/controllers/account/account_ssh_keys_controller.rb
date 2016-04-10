class Account::AccountSshKeysController < Account::BaseController
  def index
    @account_ssh_keys = current_account.ssh_keys

    @account_ssh_key = AccountSshKey.new
  end

  def create
    @ssh_key = current_account.ssh_keys.new(ssh_key_params)
    if @ssh_key.save
      redirect_to account_account_ssh_keys_path, notice: t('view.flash.create', default: 'SSH key was successfully created.')
    else
      render :index
    end
  end

  def destroy
    @ssh_key = current_account.ssh_keys.find(params[:id])
    @ssh_key.destroy

    redirect_to account_account_ssh_keys_path, notice: t('view.flash.destroy', default: 'SSH key was successfully destroyed.')
  end

  private

  def ssh_key_params
    params.require(:account_ssh_key).permit(:title, :key)
  end
end
