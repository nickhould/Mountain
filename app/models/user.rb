class User < ActiveRecord::Base
  attr_accessible :name, :password_confirmation, :password, :email

  has_secure_password
  has_many :dashboards
  has_many :authorizations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


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
end