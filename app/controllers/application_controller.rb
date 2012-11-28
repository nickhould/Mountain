class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :encode_url_for_params


	protected
  def encode_url_for_params(url)
  	URI.encode(Base64.encode64(url))
  end

  def decode_url_from_params(url)
  	URI.decode(Base64.decode64(url))
  end
end
