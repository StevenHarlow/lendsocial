require 'file_size_validator'

class Business < ActiveRecord::Base
  has_many :user_businesses
  has_many :users, through: :user_businesses
  has_many :postings, class_name: 'Message', as: 'posted_to'
  has_many :loans
  
  has_many :business_followings, foreign_key: 'followed_id'
  has_many :followers, through: :business_followings, dependent: :destroy
  
  has_many :business_connections, foreign_key: 'follower_id'
  has_many :connections, through: :business_connections, source: 'followed', conditions: "business_connections.status = 'accepted'"
  has_many :requested_connections, through: :business_connections, source: 'followed', conditions: "business_connections.status = 'requested'", order: 'business_connections.created_at'
  has_many :pending_connections, through: :business_connections, source: 'followed', conditions: "business_connections.status = 'pending'", order: 'business_connections.created_at'
  
  mount_uploader :business_picture, BusinessPictureUploader

  def latest_followers(limit = nil)
    User.where('business_followings.followed_id = ?', self.id).joins(:business_followings).order('business_followings.created_at DESC').limit(limit)
  end
  
  def latest_connections(limit = nil)
    Business.where('business_connections.followed_id = ? AND business_connections.status = ?', self.id, 'accepted').joins(:business_connections).order('business_connections.created_at DESC').limit(limit)
  end
  
  def owner
    self.users.where('role = ?', 'Owner').first
  end
  
  def request object, message
    return false if self == object || self.requested_to?(object)
    transaction do
      BusinessConnection.create(follower_id: self.id, followed_id: object.id, status: 'pending', initiator_id: self.id)
      BusinessConnection.create(follower_id: object.id, followed_id: self.id, status: 'requested', initiator_id: self.id, message: message)
    end
  end
  
  def response object, status
    return false if self == object
    return false unless [:accepted, :ignored, :cancelled].include?(status)
    transaction do
      time, status = Time.now, status.to_s
      BusinessConnection.where(follower_id: self.id, followed_id: object.id).update_all(status: status, response_at: time)
      BusinessConnection.where(follower_id: object.id, followed_id: self.id).update_all(status: status, response_at: time)
    end
  end
  
  def requested_to? object
    return false if self == object
    BusinessConnection.where(follower_id: self.id, followed_id: object.id).any?
  end
  
  def connected_to? object
    return false if self == object
    BusinessConnection.where(follower_id: self.id, followed_id: object.id, status: 'accepted').any?
  end
  
end