class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :loan
  belongs_to :business
  
  validates_numericality_of :amount, :only_integer => true, :greater_than => 0,
    :message => ': Please enter the dollar amount of your pledge'

  def self.new_pledge(amount, user, loan)
    Transaction.new do |t|
      t.tx_type = :pledge
      t.amount = amount
      t.user_id = user.id
      t.loan_id = loan.id
      t.business_id = loan.business.id
    end
  end
  
  def save_pledge(loan, message = nil)
    success_status = true
    ActiveRecord::Base.transaction do
      if !self.save
        success_status = false
      else
        # add amount to loan only if transaction passed validation
        loan.total_committed += amount
        loan.lender_count += 1
        if !loan.save
          success_status = false
        end
      end

      # try saving message (if there is one)
      # regardless of whether transaction/loan save succeeded above
      # in order to collect all validation errors in one go
      if message != nil && message.text != ''
        if !message.save
          success_status = false
        end
      end
          
      # if any validation errors occurred, rollback transaction
      if !success_status
        raise ActiveRecord::Rollback
      end
    end
    return success_status
  end
  
end
