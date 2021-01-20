CLIENT_ID = "585384591210-ju2qken74rh1ahu5keftv580tp9f3kbb.apps.googleusercontent.com"
CLIENT_SECRET = "Bnhz2PuR4CozB1rDNBOLP_S3"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, CLIENT_ID, CLIENT_SECRET, {
    prompt: "consent",
    select_account: true,
    scope: ["email", "https://www.googleapis.com/auth/gmail.readonly"]
  }
end
