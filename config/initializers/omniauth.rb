# Garb::Session.login('dashboard.ly@gmail.com', '12345Dash')
# Garb::Session.api_key = 'AIzaSyCIuZ1mgwVKpEXTezapjunkb0_rYMFEWSo'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
  {
    :scope=>"https://www.google.com/m8/feeds,https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/userinfo.profile,https://www.googleapis.com/auth/analytics.readonly",
    :approval_prompt=>"force",
    :access_type=>"offline",
  }
  provider :tumblr, ENV["TUMBLR_KEY"], ENV["TUMBLR_SECRET"]
end
