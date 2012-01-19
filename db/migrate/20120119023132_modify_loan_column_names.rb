class ModifyLoanColumnNames < ActiveRecord::Migration
  def change
  	rename_column :loans, :requestDate, :request_date
  	rename_column :loans, :amountRequested, :amount_requested
  	rename_column :loans, :fundingDeadline, :funding_deadline
	rename_column :loans, :fundedDate, :funded_date
	rename_column :loans, :totalCommitted, :total_committed
	rename_column :loans, :thankYouMessage, :thank_you_message
	rename_column :loans, :publishedDate, :published_date
  end

end
