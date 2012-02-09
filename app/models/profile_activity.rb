class ProfileActivity < ActiveRecord::Base
  belongs_to :profile
  belongs_to :actor, :class_name => 'User'    
end
