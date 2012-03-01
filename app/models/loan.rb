class Loan < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  belongs_to :loan_purpose
  
  scope :recent, lambda {|limit| order("published_date DESC").limit(limit)}
  scope :published, where("published_date IS NOT NULL")
  
  def funded
    (self.total_committed.to_s.to_d / self.amount_requested.to_s.to_d * 100).to_i
  end
end
