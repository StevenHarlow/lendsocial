module DashboardHelper
  def dashboard_notifications
    title = 'Notifications'
    notifications = current_user.business_notifications.where('viewed_at IS NULL').count
    title << " (#{notifications})" unless notifications.zero?
    title
  end
end