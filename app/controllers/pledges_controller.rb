class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @loan = Loan.find(params[:loan_id])
    @transaction = Transaction.new
    @message = Message.new
  end


  def create
    @loan = Loan.find(params[:loan_id])
    create_transaction
    update_loan
    create_message

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @transaction.save!
          @loan.save!
          @message.save! if @message.text != ''
        end
      rescue
        format.html { render action: "new" }
      else
        format.html { render :thanks, notice: 'Pledge was successfully created.' }
      end
    end
  end

  protected
  
  def create_transaction
    @transaction = Transaction.new
    @transaction.tx_type = :pledge
    @transaction.amount = params[:transaction][:amount]
    @transaction.user_id = current_user.id
    @transaction.loan_id = @loan.id
    @transaction.business_id = @loan.business.id
  end
  
  def update_loan
    @loan.total_committed += BigDecimal.new(params[:transaction][:amount])
    @loan.lender_count += 1
  end

  def create_message
    @message = @loan.business.postings.build(author_id: current_user.id)
    @message.text = params[:message][:text]
  end
  
end
