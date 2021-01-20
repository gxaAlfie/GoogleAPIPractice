class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_account_list

  def get_account_list
    @account_list = Account::List.new(session[:current_account])
  end
end
