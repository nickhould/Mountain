class OAuthManager

  attr_accessor :token, :refresh_token, :expires_at

  def initialize(authorization)
    @token = authorization.token
    @refresh_token = authorization.refresh_token
    @expires_at = authorization.expires_at
  end

  def access_token
    token_still_valid? ? token : get_refreshed_token
  end

  private

  def

  end

  def token_still_valid?
    Time.at(expires_at) > Time.now
  end

  def get_refreshed_token
    OAuth2::AccessToken.from_hash(client, :refresh_token => refresh_token).refresh!
  end

  def client
    OAuth2::Client.new( ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
                                  {
                                    :site => 'https://accounts.google.com',
                                    :authorize_url => "/o/oauth2/auth",
                                    :token_url => "/o/oauth2/token",
                                  })
  end
end