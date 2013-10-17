require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    OmniAuth.config.test_mode = true
    @auth = ActiveSupport::HashWithIndifferentAccess.new(
      'user_info' => {
        'name' => 'Mario Brothers',
        'image' => '',
        'email' => 'dpsk@email.ru' },
      'uid' => '123545',
      'provider' => 'tumblr',
      'credentials' => {'token' => 'token'}
      )
  end

  test "should be able to create a user from valid auth response" do
    assert_true User.from_omniauth(@auth)
  end
end
