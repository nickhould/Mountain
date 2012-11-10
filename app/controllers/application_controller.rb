class ApplicationController < ActionController::Base
  protect_from_forgery


def top_pages
  ga = GoogleAnalytics.new
  return ga.profile.pages.sort_by{|e| e.pageviews.to_i}.reverse.take(10)
end

end
