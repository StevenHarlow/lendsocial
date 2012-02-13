class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :user_businesses
  has_many :businesses, :through => :user_businesses
  has_many :messages, :foreign_key => :author_id
  has_many :postings, :class_name => "Message", :as => :posted_to
  has_many :follower_associations, :class_name => "UserFollowing", :foreign_key => :followed_id
  has_many :followers, :through => :follower_associations, :source => :follower, :dependent => :destroy
  has_many :followed_user_associations, :class_name => "UserFollowing", :foreign_key => :follower_id
  has_many :followed_users, :through => :followed_user_associations, :source => :followed, :dependent => :destroy
  has_many :followed_business_associations, :class_name => "BusinessFollowing", :foreign_key => :follower_id
  has_many :followed_businesses, :through => :followed_business_associations, :source => :followed, :dependent => :destroy
  
  def name
    self.email # temp solution
  end
  
  def address
    "Berkeley, CA"
  end
  
  def follow object
    return false if object.class == User && self.id == object.id
    klass = "#{object.class.name}Following".constantize
    klass.create(:follower_id => self.id, :followed_id => object.id)
  end
  
  def unfollow object
    return false if object.class == User && self.id == object.id
    klass = "#{object.class.name}Following".constantize
    klass.where(:follower_id => self.id).delete_all
  end
  
  def is_following? object
    return false if object.class == User && self.id == object.id
    klass = "#{object.class.name}Following".constantize
    klass.where(:follower_id => self.id).any?
  end
  
end