class User < ActiveRecord::Base
    acts_as_authentic
    
    has_many :profiles
    has_many :following, :class_name => "Followings", :foreign_key => "follower_id"
end
