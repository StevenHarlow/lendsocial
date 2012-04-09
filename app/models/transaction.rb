class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :loan
  belongs_to :business
end
