class DashboardController < ApplicationController
  include DashboardHelper
  before_filter :require_user
  
  def index
    @recent_loans = Loan.recent(3).published
    @status_message = current_user.messages.build(author_id: current_user.id, posted_to_id: current_user.id, posted_to_type: 'User')
  end
  
  def update_status
    @messages = current_user.messages.page(params[:page] || 1)
    respond_to_xhr 'messages/list'
  end
  
  def archived_statuses
    @messages = current_user.messages.page(params[:page] || 1)
    respond_to_xhr 'messages/list'
  end
  
  def notifications
    @notifications = current_user.business_notifications.page(params[:page] || 1)
    respond_to_xhr 'notifications/list'
  end
  
  def notifications_update
    if request.xhr?
      current_user.business_notifications.where("status = 'accepted' AND viewed_at IS NULL").each do |notification|
        notification.viewed_at = Time.now
        notification.save!
      end
      respond_to do |format|
        format.json {render json: {}}
      end
    else
      redirect_to dashboard_index_path
    end
  end
  
  def notifications_counter
    if request.xhr?
      render inline: dashboard_notifications
    else
      redirect_to dashboard_index_path
    end
  end
  
  private
  
  def respond_to_xhr template
    if request.xhr?
      render template: template, layout: false
    else
      redirect_to dashboard_index_path
    end
  end
end