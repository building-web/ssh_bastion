class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :account_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end

  private

  def pundit_user
    current_account
  end

  def account_not_authorized
    flash[:alert] = t('controller.not_authorized', default: "You have not authorized to handle this")
    redirect_to(request.referrer || account_root_path)
  end
end
