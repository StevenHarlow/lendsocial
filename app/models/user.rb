class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :user_businesses
  has_many :businesses, :through => :user_businesses
  has_many :profiles, :foreign_key => "owner_id"
  has_many :following, :class_name => "Followings", :foreign_key => "follower_id"
  has_many :messages, :foreign_key => "author_id"
  has_many :postings, :class_name => "Message", :as => :posted_to
end
