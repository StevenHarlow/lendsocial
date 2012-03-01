class Message < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :by_business, class_name: 'Business'
  belongs_to :posted_to, polymorphic: true
  belongs_to :related_message, class_name: 'Message'
  has_many :comments_on, class_name: 'Message', foreign_key: 'related_message_id'
  
  validates_presence_of :text
  validates_length_of :text, in: 1..2000
  
  default_scope order('created_at DESC')

  scope :for_user, lambda {|user| where(posted_to_id: user.id, posted_to_type: 'User')}
  scope :for_business, lambda {|business| where(posted_to_id: business.id, posted_to_type: 'Business')}
  scope :with_comments, includes('comments_on')
  
  paginates_per 10
  
  def writer
    self.author || self.by_business
  end
end
