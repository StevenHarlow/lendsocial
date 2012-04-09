class LoansController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @loans = Loan.page(params[:page] || 1)
  end

end
