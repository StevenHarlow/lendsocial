class Loan < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  belongs_to :loan_purpose
  
  scope :recent, lambda {|limit| order("published_date DESC").limit(limit)}
  scope :published, where("published_date IS NOT NULL")
  
  def funded
    total_committed = self.total_committed.is_a?(BigDecimal) ? self.total_committed : BigDecimal(self.total_committed.to_s)
    (total_committed / self.amount_requested * 100).to_i
  end
end
