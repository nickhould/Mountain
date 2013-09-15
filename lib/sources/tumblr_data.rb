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

  def blog(url)
    blog = @client.info["user"]["blogs"].select do |blog|
      blog["url"] == url
    end
    blog ? blog.first : nil
  end


  def total_posts(url)
    blog = blog(url)
    total_posts_number = blog["posts"]
  end

  def blogs
    @client.info["user"]["blogs"] if @client.info["user"]
  end

  def posts(url)
    @client.posts(parse_url(url))["posts"]
  end

  def all_posts(url)
    blog = blog(url)
    total_posts_number = blog["posts"].to_i
    url = parse_url(blog["url"])
    limit = 45
    offset = 0
    posts = []
    while posts.length < total_posts_number
      @client.posts(url, offset: offset, limit: limit)["posts"].each do |post|
        post = [ post ]
        posts << post
      end
      offset += limit
    end
    posts
  end

  def parse_url(url)
    url = Domainatrix.parse(url)
    if url.domain == "tumblr"
      url.host
    else
      url.subdomain + url.host
    end
  end
end