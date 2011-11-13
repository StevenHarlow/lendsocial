class Profile < ActiveRecord::Base
    has_many :followers, :class_name => "Followings", :foreign_key => "profile_id"
    has_many :profile_activities
    belongs_to :owner, :class_name => "User"
end
