module AuthorizationsHelper

  def google_auth_url
    "/auth/google_oauth2"
  end

  def tumblr_auth_url
    "/auth/tumblr"
  end

  def destroy_google_auth
    authorizations
  end

  def google_auth
    current_user.authorizations.find_by_provider("google") or
    current_user.authorizations.find_by_provider("google_oauth2")
  end

  def tumblr_auth
    current_user.authorizations.find_by_provider("tumblr")
  end
end
