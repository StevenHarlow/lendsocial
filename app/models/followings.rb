class Followings < ActiveRecord::Base
    validates_uniqueness_of  :profile_id, :scope => [:follower_id]
    belongs_to :profile
    belongs_to :follower, :class_name => "User"
end
