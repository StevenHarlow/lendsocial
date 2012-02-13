class Message < ActiveRecord::Base
  belongs_to :message_type
  belongs_to :author, :class_name => "User"
  belongs_to :posted_to, :polymorphic => true
  belongs_to :related_message, :class_name => "Message"
  has_many :comments_on, :class_name => "Message", :foreign_key => "related_message_id"
  
  validates_presence_of :text
  validates_length_of :text, :in => 8..255
  
  default_scope order("created_at DESC")

  scope :statuses, where("message_type_id = ?", 1)
  scope :postings, where("message_type_id = ?", 2)
  scope :for_user, lambda {|user| where("posted_to_id = ? AND posted_to_type = ?", user.id, "User")}
  scope :for_business, lambda {|business| where("posted_to_id = ? AND posted_to_type = ?", business.id, "Business")}
  
  paginates_per 10
end
