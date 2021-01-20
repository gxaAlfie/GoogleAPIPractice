class Account::List
  attr_reader :current_account, :other_accounts

  def initialize(current_account_id=nil)
    @current_account = Account.find(current_account_id) rescue nil
    @other_accounts  = Account.where.not(id: current_account_id).order(:email)
  end
end
