class Profile < ActiveRecord::Base
    has_many :followers, :class_name => "Followings", :foreign_key => "profile_id"
    belongs_to :owner, :class_name => "User"
end
