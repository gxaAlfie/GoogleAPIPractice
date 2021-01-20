class AccountsController < ApplicationController
  before_action :set_account, only: :show

  def index
  end

  def show
    set_session_account
  end

  private
  def set_account
    @account = Account.find(params[:id])
  end

  def set_session_account
    session[:current_account] = params[:id].to_i
  end
end
