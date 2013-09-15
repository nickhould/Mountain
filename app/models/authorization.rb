class Authorization < ActiveRecord::Base
  after_save :create_all_blogs_from_tumblr, if: :from_tumblr?
  attr_accessible :provider, :user_id, :uid, :token, :secret

  belongs_to :user
  has_many :blogs

  validates :token, :secret, :provider, :uid, :presence => true
  validates :provider, :uniqueness => {:scope => :user_id,
                                       :message => "already authorized for this provider." }

  def create_all_blogs_from_tumblr
    blogs.create_all_from_tumblr(token, secret)
  end

  def from_tumblr?
    provider.downcase == "tumblr"
  end
end
