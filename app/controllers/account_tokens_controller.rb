class AccountTokensController < ApplicationController
  def update
    @account = if account = Account.where(uid: auth.uid).first
      account.update_attributes(account_attributes)
    else
      Account.create(account_attributes)
    end

    redirect_to root_path, alert: "Success"
  end

  def failure
    redirect_to root_path, alert: "Failed"
  end

  private

  def auth
    request.env["omniauth.auth"]
  end

  def account_attributes
    {
      provider: auth.provider,
      uid: auth.uid,
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      token_expiration: Time.at(auth.credentials.expires_at).utc,
      email: auth.info.email
    }
  end
end
