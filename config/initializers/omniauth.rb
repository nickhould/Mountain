Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, 
		'923265303062.apps.googleusercontent.com', 
		'Orqj3qegwPwHRs_cxe-vVBV3', {scope: "https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/userinfo.profile,https://www.googleapis.com/auth/analytics"}
end
