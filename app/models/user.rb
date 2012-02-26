class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :user_businesses
  has_many :businesses, through: :user_businesses
  has_many :messages, foreign_key: 'author_id'
  has_many :postings, class_name: 'Message', as: 'posted_to'
  has_many :follower_associations, class_name: 'UserFollowing', foreign_key: 'followed_id'
  has_many :followers, through: :follower_associations, source: 'follower', dependent: :destroy
  has_many :followed_user_associations, class_name: 'UserFollowing', foreign_key: 'follower_id'
  has_many :followed_users, through: :followed_user_associations, source: 'followed', dependent: :destroy
  has_many :business_followings, foreign_key: 'followed_id'
  has_many :followed_businesses, through: :business_followings, source: 'followed', dependent: :destroy
  
  def name
    "#{self.first_name} #{self.last_name}".strip
  end
  
  def full_address
    "#{self.address}, #{self.city}, #{self.state} #{self.zipcode}".strip
  end
  
  def follow object
    return false if object == self
    klass = "#{object.class.name}Following".constantize
    klass.create(follower_id: self.id, followed_id: object.id)
  end
  
  def unfollow object
    return false if object == self
    klass = "#{object.class.name}Following".constantize
    klass.where(follower_id: self.id, followed_id: object.id).delete_all
  end
  
  def is_following? object
    return false if object == self
    klass = "#{object.class.name}Following".constantize
    klass.where(follower_id: self.id, followed_id: object.id).any?
  end
  
  def business_notifications
    BusinessConnection.includes(:followed).where("follower_id = ? AND (status = 'requested' OR (status = 'accepted' AND initiator_id = ?))", self.id, self.id).order('status DESC, created_at DESC')
  end
  
end