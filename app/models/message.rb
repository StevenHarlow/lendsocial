class Message < ActiveRecord::Base
  belongs_to :message_type
  belongs_to :author, :class_name => "User"
  belongs_to :posted_to, :polymorphic => true
  belongs_to :related_message, :class_name => "Message"
  has_many :comments_on, :class_name => "Message", :foreign_key => "related_message_id"
end
