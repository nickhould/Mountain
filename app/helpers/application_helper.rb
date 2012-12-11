module ApplicationHelper

	def current_user?
		@user ||= User.find_by_id(session[:user_id])
	end

  def default_dashboard_url
    if current_user && current.user.try(:dashboards)
      dashboard_url(current_user.dashboards.first)
    else
      new_dashboard_url
    end
  end
end
