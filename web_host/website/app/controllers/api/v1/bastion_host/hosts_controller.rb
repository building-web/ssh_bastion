class Api::V1::BastionHost::HostsController < Api::V1::ApiController

  before_action :find_bastion_host
  before_action :verify_sign_and_decrypt_data

  def list
    authentication_u = @data.fetch(:authentication_u)
    authentication_k = @data.fetch(:authentication_k)
    resp_body_template = @data.fetch(:resp_body_template)

    if authentication_u.to_s != @bastion_host.user
      return render json: {err_msg: "invalid_authentication_u"}, status: 401
    end

    account = Account.find_by_ssh_public_key(authentication_k)
    if account.nil?
      return render json: {err_msg: "invalid_authentication_k"}, status: 401
    end

    hosts = account.hosts
    # TODO
  end

  private

  def find_bastion_host
    @bastion_host = ::BastionHost.find_by!(ip: request.remote_ip)
  end

  def verify_sign_and_decrypt_data
    encrypted_data = params[:encrypted_data]
    encrypted_data_sign = params[:encrypted_data_sign]

    gpg_recipient = WebHost.first.gpg_key_id
    gpg_signer = @bastion_host.gpg_key.key_id

    gpg_crypto = GPGME::Crypto.new(recipients: gpg_recipient, signers: gpg_signer, armor: true, always_trust: true)

    sign_valid = false
    gpg_crypto.verify(encrypted_data_sign, signed_text: encrypted_data) do |signature|
      sign_valid = signature.valid?
    end

    unless sign_valid
      return render json: {err_msg: "invalid_sign"}, status: 422
    end

    @data = gpg_crypto.decrypt(encrypted_data)
  end

end
