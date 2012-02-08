class Business < ActiveRecord::Base
    has_many :user_businesses
    has_many :users, :through => :user_businesses
    has_many :postings, :class_name => "Message", :as => :posted_to
end
