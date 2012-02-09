class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :user_businesses
  has_many :businesses, :through => :user_businesses
  has_many :messages, :foreign_key => "author_id"
  has_many :postings, :class_name => "Message", :as => :posted_to
end
