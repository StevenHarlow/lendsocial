class DashboardController < ApplicationController
  before_filter :require_user
  
  def index
    @recent_loans = Loan.recent(3).published
    @status_message = current_user.messages.build(message_type_id: 1)
  end
  
  def update_status
    @messages = Message.statuses.page(params[:page] || 1)
    respond_to_xhr
  end
  
  def archived_statuses
    @messages = current_user.messages.page(params[:page] || 1)
    respond_to_xhr
  end
  
  private
  
  def respond_to_xhr
    if request.xhr?
      respond_to do |format|
        format.html {render template: 'messages/list', layout: false}
      end
    else
      redirect_to dashboard_index_path
    end
  end
end