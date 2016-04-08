class Account::SshKeysController < Account::BaseController
  def index
    @ssh_keys = current_account.ssh_keys
  end

  def new
  end

  def destroy
  end

  private

  def ssh_key_params

  end
end
