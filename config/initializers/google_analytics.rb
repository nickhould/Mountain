# Garb::Session.login('dashboard.ly@gmail.com', '12345Dash')
# Garb::Session.api_key = 'AIzaSyCIuZ1mgwVKpEXTezapjunkb0_rYMFEWSo'

api_key = "tKHc-DDjWZu3mern4k1u7ndN"
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google, '472837297406.apps.googleusercontent.com', api_key, scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.google.com/analytics/feeds/'
  provider :tumblr, "wKKJaFBh5fAM1tI9xc4l3QNdBQs6Qdczk4C91a3PlLDgx5LFoL", "s7JxIwrNQRlLmUpAqXW14RK0li435g2391quzltIsn5mmt5g6F"
end