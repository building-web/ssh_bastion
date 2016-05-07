class Account::AccountsController < Account::BaseController
  before_action :set_account, only: [:edit, :update, :destroy]
  def index
    @accounts = Account.all.page(params[:page])

    authorize @accounts, :index?
  end

  def new
    @account = Account.new

    authorize @account, :new?
  end

  def create
    @account = Account.new(params_account)

    authorize @account, :create?

    if @account.save
      @account.send_reset_password_instructions

      redirect_to account_accounts_path, notice: t('flash.actions.create.notice', resource_name: 'Account')
    else
      render :new
    end
  end
  #  TODO
  # def edit
  #   authorize @account, :edit?
  # end

  # def update
  #   authorize @account, :update

  #   if @account.update_without_password(role: params[:account][:role])
  #     redirect_to account_accounts_path, notice: t('flash.actions.update.notice', resource_name: 'Account')
  #   else
  #     render :new
  #   end
  # end

  def destroy
    authorize @account, :destroy?

    if @account.destroy
      redirect_to account_accounts_path, notice: t('flash.actions.destroy.notice', resource_name: 'Account')
    else
      redirect_to account_accounts_path, notice: t('flash.actions.destroy.alert', resource_name: 'Account')
    end
  end

  private

  def params_account
    _attrs = params.require(:account).permit(:email, :role)
    _attrs[:password] = Devise.friendly_token
    _attrs
  end

  def set_account
    @account = Account.find(params[:id])
  end
end
