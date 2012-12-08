class Authorization < ActiveRecord::Base
  attr_accessible :access_token, :provider, :user_id
  belongs_to :user
end
