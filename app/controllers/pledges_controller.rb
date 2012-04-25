class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @loan = Loan.find(params[:loan_id])
    @transaction = Transaction.new
    @message = Message.new
  end

  def create
    @loan = Loan.find(params[:loan_id])
    @transaction = Transaction.new_pledge(params[:transaction][:amount], current_user, @loan)
    @message = @loan.business.postings.build(author_id: current_user.id, text: params[:message][:text])
    
    respond_to do |format|
      if @transaction.save_pledge(@loan, @message)
        format.html { render :thanks, notice: 'Pledge was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
end
