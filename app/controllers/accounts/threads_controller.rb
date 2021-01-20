class Accounts::ThreadsController < ApplicationController
  before_action :set_account
  
  def index
  end

  private
  def set_account
    @account = Account.find(params[:account_id])
  end
end
