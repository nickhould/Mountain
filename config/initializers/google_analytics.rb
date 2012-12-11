# Garb::Session.login('dashboard.ly@gmail.com', '12345Dash')
# Garb::Session.api_key = 'AIzaSyCIuZ1mgwVKpEXTezapjunkb0_rYMFEWSo'

api_key = "tKHc-DDjWZu3mern4k1u7ndN"
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google, Figaro.env.google_app_url, Figaro.env.google_api_key, scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.google.com/analytics/feeds/'
  provider :tumblr, Figaro.env.tumblr_key, Figaro.env.tumblr_secret
end

