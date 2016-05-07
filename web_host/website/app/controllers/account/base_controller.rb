class Account::BaseController < ApplicationController

  layout 'account_signed'

  before_action :authenticate_account!

end
