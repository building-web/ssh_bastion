class Api::V1::BastionHost::HostsController < Api::V1::ApiController

  before_action :find_bastion_host

  def index
    encrypted_data = params[:encrypted_data]
    encrypted_data_sign = params[:encrypted_data_sign]
  end

  private

  def find_bastion_host
    @bastion_host = ::BastionHost.find_by!(ip: request.remote_ip)
  end

end
