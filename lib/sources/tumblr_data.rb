class TumblrData
  def initialize(token, secret)
    configure_session(token, secret)
    @client = Tumblr.new
  end

  def configure_session(token, secret)
    Tumblr.configure do |config|
        config.consumer_key = ENV["TUMBLR_KEY"]
        config.consumer_secret = ENV["TUMBLR_SECRET"]
        config.oauth_token = token
        config.oauth_token_secret = secret
    end
  end

  def blogs
    @client.info["user"]["blogs"]  
  end

  def posts(url, options = {})
    @client.posts(url)
  end
end


