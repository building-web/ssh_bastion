class Account::AssignedHostsController < Account::BaseController
  def index
    @assigned_hosts = current_account.assigned_hosts.page(params[:page])

    authorize @assigned_hosts, :index?
  end
end
