class Profile < ActiveRecord::Base
    has_many :followers, :class_name => "Followings", :foreign_key => "profile_id"
    has_one :owner, :class_name => "User"
end
