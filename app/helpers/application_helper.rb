module ApplicationHelper

	def current_user?
    # refactor this method to return true or false
		@user ||= User.find_by_id(session[:user_id])
	end

  def default_dashboard_url
    if current_user && current_user.has_dashboard?
      dashboard_url(current_user.dashboards.first.id)
    else
      new_dashboard_url
    end
  end
end
