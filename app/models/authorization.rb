class Authorization < ActiveRecord::Base
  after_save :create_all_blogs_from_tumblr, if: :from_tumblr?
  attr_accessible :provider, :user_id, :uid, :token, :secret, :refresh_token, :expires_at

  belongs_to :user
  has_many :blogs

  validates :token, :provider, :uid, :presence => true
  validates :provider, :uniqueness => {:scope => :user_id,
                                       :message => "already authorized for this provider." }

  def self.from_omniauth(auth, current_user)
    current_user.authorizations.new( token: auth.credentials.token,
                                     secret: auth.credentials.secret,
                                     uid: auth.uid,
                                     refresh_token: auth.credentials.refresh_token,
                                     provider: auth.provider,
                                     expires_at: auth.credentials.expires_at,
                                   )
  end

  def create_all_blogs_from_tumblr
    blogs.create_all_from_tumblr(token, secret)
  end

  def from_tumblr?
    provider.downcase == "tumblr"
  end
end
