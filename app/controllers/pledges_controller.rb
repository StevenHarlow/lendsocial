class PledgesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @loan = Loan.find(params[:loan_id])
    @transaction = Transaction.new
  end


  def create
    @loan = Loan.find(params[:loan_id])
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if true #@transaction.save
        format.html { render :show, notice: 'Pledge was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
end
