require "google/apis/gmail_v1"
require "net/http"

class GmailApi
  def initialize(account)
    @account = account
    @service = get_mail_service
  end

  def fetch_threads(labels, query)
    threads = []
    check_token_validity do
      thread_list = get_thread_list(labels, query)
      @service.batch do |service|
        threads = get_thread_data_from_list(service, thread_list)
      end
    end
    threads
  end

  private

  def get_thread_data_from_list(service, thread_list = [])
    gmail_threads = []
    thread_list.each do |thread|
      service.get_user_thread("me", thread.id) do |result, error|
        gmail_threads << Gmail::Thread.new(result) if error.blank?
      end
    end
    gmail_threads
  end

  def get_thread_list(labels, query)
    @service.list_user_threads(@account.uid, label_ids: labels, max_results: 10).threads
  end

  def check_token_validity
    begin
      if expired_token?
        refresh_account_token
        initialize(@account)
      end
      yield
    rescue StandardError => error
      puts "THIS IS AN ERROR: #{error}"
    end
  end

  def refresh_account_token
    url = URI("https://accounts.google.com/o/oauth2/token")
    data = JSON.parse(Net::HTTP.post_form(url, {
      "refresh_token" => @account.refresh_token,
      "client_id" => CLIENT_ID,
      "client_secret" => CLIENT_SECRET,
      "grant_type" => "refresh_token"
    }).body)
    @account.update_attributes(token: data["access_token"])
  end

  def expired_token?
    Time.now.utc.to_i > @account.token_expiration.to_i
  end

  def get_mail_service
    service = Google::Apis::GmailV1::GmailService.new
    service.client_options.application_name = "General Google API"
    service.authorization = @account.token
    service
  end
end
