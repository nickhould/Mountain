# Garb::Session.login('dashboard.ly@gmail.com', '12345Dash')
# Garb::Session.api_key = 'AIzaSyCIuZ1mgwVKpEXTezapjunkb0_rYMFEWSo'

api_key = "tKHc-DDjWZu3mern4k1u7ndN"
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google, ENV["GOOGLE_APP_URL"], ENV["GOOGLE_API_KEY"], scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.google.com/analytics/feeds/'
  provider :tumblr, ENV["TUMBLR_KEY"], ENV["TUMBLR_SECRET"]

end



