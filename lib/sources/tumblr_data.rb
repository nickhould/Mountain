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
    
  # def create_blogs
  #   configure_tumblr
  #   client = Tumblr.new
  #   blogs = client.info["user"]["blogs"]  
  #   blogs.each do |blog|
  #     Tumblog.create(
  #       url: blog["url"],
  #       title: blog["title"],
  #       followers: blog["followers"],
  #       posts: blog["posts"],
  #       updated: blog["updated"]
  #       )
  #   end
  # end

end


