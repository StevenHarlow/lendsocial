class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :loan
  belongs_to :business
  
  validates_presence_of :amount
  validates :amount, :numericality => { :only_integer => true, :greater_than => 0 }
end
