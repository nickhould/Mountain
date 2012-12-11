class Authorization < ActiveRecord::Base
  attr_accessible :access_token, :provider, :user_id, :uid, :token, :secret
  belongs_to :user

  def google_token
    find_by_provider("google").first.token
  end

  def google_secret
    find_by_provider("google").first.secret
  end

  def google
    find_by_provider("google")
  end
end
