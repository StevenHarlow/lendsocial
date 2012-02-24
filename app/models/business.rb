class Business < ActiveRecord::Base
  has_many :user_businesses
  has_many :users, through: :user_businesses
  has_many :postings, class_name: 'Message', as: 'posted_to'
  has_many :loans
  belongs_to :industry, class_name: 'BusinessIndustry', foreign_key: 'business_industry_id'
  
  has_many :business_followings, foreign_key: 'followed_id'
  has_many :followers, through: :business_followings, dependent: :destroy
  
  has_many :business_follower_connections, class_name: 'BusinessConnection', foreign_key: 'follower_id'
  has_many :connections, through: :business_follower_connections, source: 'followed', conditions: "business_connections.status = 'accepted'"
  has_many :pending_connections, through: :business_follower_connections, source: 'followed', conditions: "business_connections.status = 'requested'", order: 'business_connections.created_at'

  has_many :business_followed_connections, class_name: 'BusinessConnection', foreign_key: 'followed_id'
  has_many :requested_connections, through: :business_followed_connections, source: 'follower', conditions: "business_connections.status = 'requested'", order: 'business_connections.created_at'
  

  def latest_followers(limit = nil)
    User.where('business_followings.followed_id = ?', self.id).joins(:business_followings).order('business_followings.created_at DESC').limit(limit)
  end
  
  def latest_connections(limit = nil)
    Business.where('business_connections.followed_id = ?', self.id).joins(:business_follower_associations).order('business_connections.created_at DESC').limit(limit)
  end
  
  def owner
    self.users.where('role = ?', 'Owner').first
  end
  
  def connect object
    return false if object == self
    BusinessConnection.create(follower_id: self.id, followed_id: object.id)
  end
  
  def disconnect object
    return false if object == self
    BusinessConnection.create(follower_id: self.id).delete_all
  end
  
  def is_connected? object
    return false if object == self
    BusinessConnection.where(follower_id: self.id).any?
  end
end