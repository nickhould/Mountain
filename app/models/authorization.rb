class Authorization < ActiveRecord::Base
  attr_accessible :access_token, :provider, :user_id, :uid, :token, :secret
  belongs_to :user

  def self.from_omniauth(auth, google_token, google_secret)
    where(provider: auth.provider, uid: auth.uid).first || create_from_omniauth(auth, google_token, google_secret)
  end


  def self.create_from_omniauth(auth, google_token, google_secret)
    @user = User.new
    @authorization = @user.authorization.new
    @authorizations.provider = auth.provider
    @user.authorizations.uid = auth.uid
    @user.save
    @user
  end

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
