class Followings < ActiveRecord::Base
    belongs_to :profile
    belongs_to :follower, :class_name => "User"
end
