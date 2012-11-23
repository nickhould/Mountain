class Dashboard < ActiveRecord::Base
  attr_accessible :name, :web_property_id

  belongs_to :user
end
