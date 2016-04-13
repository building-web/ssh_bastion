class Account::HostsController < Account::BaseController
  before_action :set_host, only: [:edit, :update, :destroy]

  def index
    # these hosts inlcude two part, ones created, ones aimed, I think we should divded them
    @hosts = current_account.creator_hosts
  end

  def new
    @host = current_account.creator_hosts.new

    authorize @host, :handle?

    @host.build_host_user_app
    @host.build_host_user_dev
  end

  def create
    @host = current_account.creator_hosts.new(host_param)

    authorize @host, :handle?

    if @host.save
      redirect_to account_hosts_path, notice: t('flash.actions.create.notice', resource_name: 'Host')
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @host, :handle?

    if @host.update(host_param)
      redirect_to account_hosts_path, notice: t('flash.actions.update.notice', resource_name: 'Host')
    else
      render :edit
    end
  end

  def destroy
    authorize @host, :handle?

    if @account_ssh_key.destroy
      redirect_to account_hosts_path, notice: t('flash.actions.destroy.notice', resource_name: 'Host')
    else
      ###  TODO
    end
  end

  private
  def set_host
    @host = current_account.creator_hosts.find(params[:id])
  end

  def host_param
    params.require(:host).permit(
      :ip, :port, :comment,
      host_user_app_attributes: [:id, :name],
      host_user_dev_attributes: [:id, :name],
      )
  end
end
