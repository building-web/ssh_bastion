class Account::HostsController < Account::BaseController
  before_action :set_host, only: [:edit, :update, :destroy]

  def index
    @hosts = current_account.hosts.page(params[:page])

    authorize @hosts, :index?
  end

  def new
    @host = current_account.hosts.new

    authorize @host, :new?

    2.times { @host.host_users.new }
  end

  def create
    @host = current_account.hosts.new(host_param)

    authorize @host, :create?

    if @host.save
      redirect_to account_hosts_path, notice: t('flash.actions.create.notice', resource_name: 'Host')
    else
      render :new
    end
  end

  def edit
    authorize @host, :edit?
  end

  def update
    authorize @host, :update?

    if @host.update(host_param)
      redirect_to account_hosts_path, notice: t('flash.actions.update.notice', resource_name: 'Host')
    else
      render :edit
    end
  end

  def destroy
    authorize @host, :destroy?

    if @host.destroy
      redirect_to account_hosts_path, notice: t('flash.actions.destroy.notice', resource_name: 'Host')
    else
      redirect_to account_host_path(@host), notice: t('flash.actions.destroy.alert', resource_name: 'Host')
    end
  end

  private
  def set_host
    @host = current_account.hosts.find(params[:id])
  end

  def host_param
    params.require(:host).permit(
      :ip, :port, :comment,
      host_users_attributes: [:id, :name],
      )
  end
end
