require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    OmniAuth.config.test_mode = true
    @auth = Hashie::Mash.new(
      'user_info' => {
        'name' => 'Mario Brothers',
        'image' => '',
        'email' => 'dpsk@email.ru' },
      'uid' => '123545',
      'provider' => 'tumblr',
      'credentials' => { 'token' => 'token', 'secret' => 'secret' }
      )
  end

  test "should create a new user and a new authorization if user doesn't exist" do
    user_initial_count = User.count
    authorization_initial_count = Authorization.count
    User.from_omniauth(@auth)
    assert_equal ( user_initial_count + 1 ), User.count
    assert_equal ( authorization_initial_count + 1 ), Authorization.count
  end

  test "should create a valid new authorization if user doesn't exist" do
    user = User.from_omniauth(@auth)
    user_authorization = user.authorizations.first
    assert_equal @auth.uid, user_authorization.uid
    assert_equal @auth.provider, user_authorization.provider
    assert_equal @auth.credentials.token, user_authorization.token
    assert_equal @auth.credentials.secret, user_authorization.secret
  end

  test "should not create a new user or authorization if existing authorization" do
    first_user = User.from_omniauth(@auth)
    user_initial_count = User.count
    second_user = User.from_omniauth(@auth)
    assert_equal first_user, second_user
  end
end
