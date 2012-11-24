class Dashboard < ActiveRecord::Base
  attr_accessible :name, :web_property_id, :user_id

  belongs_to :user

	validates_presence_of :name, :web_property_id, :user_id
end
