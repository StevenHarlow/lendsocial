class DashboardController < ApplicationController
  def index
    @recent_loans = Loan.recent(3).published
  end
end