# Garb::Session.login('dashboard.ly@gmail.com', '12345Dash')
# Garb::Session.api_key = 'AIzaSyCIuZ1mgwVKpEXTezapjunkb0_rYMFEWSo'

api_key = "tKHc-DDjWZu3mern4k1u7ndN"
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google, '472837297406.apps.googleusercontent.com', api_key, scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.google.com/analytics/feeds/'
end