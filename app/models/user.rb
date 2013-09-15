class User < ActiveRecord::Base
  attr_accessible :name, :password_confirmation, :password, :email

  has_secure_password
  has_many :dashboards
  has_many :authorizations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }



  def self.update_blogs
    all.each { |user| create_all_blogs_from_tumblr(user) }
  end

  def tumblr_token
    authorization_from_tumblr.token
  end

  def tumblr_secret
    authorization_from_tumblr.secret
  end

  def authorization_from_tumblr
    self.authorizations.find_by_provider("tumblr") if authorizations
  end

  def authorization_from_google
    self.authorizations.find_by_provider("google") if authorizations
  end

  def create_blogs_from_tumblr(tumblr_token, tumblr_secret)
    authorization_from_tumblr.blogs.create_all_from_tumblr(tumblr_token, tumblr_secret)
  end

  def blogs_from_tumblr
    authorization_from_tumblr.blogs.all
  end

  def identify_properties
    {
      email: email,
      created: created_at,
      created_at: created_at,
      updated_at: updated_at,
      has_dashboard: has_dashboard?,
      dashboard_count: dashboard_count,
      has_authorization: has_authorization?,
      authorization_count: authorization_count,
      has_blog: has_blog?,
      blog_count: blog_count
    }.to_json
  end

  def has_dashboard?
    dashboards.any? ? true : false
  end

  def dashboard_count
    has_dashboard? ? dashboards.count : 0
  end

  def has_authorization?
    authorizations.any? ? true : false
  end

  def authorization_count
    has_authorization? ? authorizations.count : 0
  end

  def has_blog?
    ( authorization_from_tumblr && authorization_from_tumblr.blogs ) ? true : false
  end

  def blog_count
    has_blog? ? authorization_from_tumblr.blogs.count : 0
  end


protected
  def self.create_all_blogs_from_tumblr(user)
    auth = user.authorization_from_tumblr
    auth.create_all_blogs_from_tumblr if auth
  end

end