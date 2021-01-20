class Accounts::FetchThreadsController < ApplicationController
  before_action :set_account

  def index
    gmail_list = GmailApi.new(@account).fetch_threads("INBOX", "")
    render json: { threads: gmail_list }
  end

  private
  def set_account
    @account = Account.find(params[:account_id])
  end
end
