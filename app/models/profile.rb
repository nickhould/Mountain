class Profile < ActiveRecord::Base
  attr_accessible :title, :web_property_id, :user_id

  belongs_to :user

end
