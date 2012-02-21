class Business < ActiveRecord::Base
  has_many :user_businesses
  has_many :users, :through => :user_businesses
  has_many :postings, :class_name => "Message", :as => :posted_to
  has_many :loans
  belongs_to :industry, :class_name => "BusinessIndustry", :foreign_key => "business_industry_id"
  has_many :follower_associations, :class_name => "BusinessFollowing", :foreign_key => "followed_id"
  has_many :followers, :through => :follower_associations, :source => :follower
  has_many :business_connection_follower_associations, :class_name => "BusinessConnection", :foreign_key => :followed_id
  has_many :business_connection_followers, :through => :business_connection_follower_associations, :source => :follower, :dependent => :destroy
  has_many :followed_business_connection_associations, :class_name => "BusinessConnection", :foreign_key => :follower_id
  has_many :followed_business_connections, :through => :followed_business_connection_followed_associations, :source => :followed, :dependent => :destroy
  
  def latest_followers(limit = nil)
    User.where('business_followings.followed_id = ?', self.id).joins(:followed_businesses).order('business_followings.created_at DESC').limit(limit)
  end
  
  def owner
    self.users.where("role = ?", "Owner").first
  end
end