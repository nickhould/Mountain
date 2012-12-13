module ApplicationHelper

	def current_user?
    # refactor this method to return true or false
    if session[:user_id]
		  @user ||= User.find_by_id(session[:user_id])
    end
	end
end
