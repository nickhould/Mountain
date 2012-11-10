class Exits
  extend Garb::Model

  metrics :exits, :pageviews
  dimensions :page_path
end

class Visits
  extend Garb::Model

  metrics :visits
end

class Sources
  extend Garb::Model

  metrics :visits
  dimensions :source
end

class Pages
	extend Garb::Model

	metrics :pageViews
	dimensions :pageTitle
end