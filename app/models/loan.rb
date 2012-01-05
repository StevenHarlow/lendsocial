class Loan < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  belongs_to :loan_purpose
end
