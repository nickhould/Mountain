class Exits
  extend Garb::Model

  metrics :exits, :pageviews
  dimensions :page_path
end


class Visitstotal
  extend Garb::Model

  metrics :visits
end

class Visits
  extend Garb::Model

  metrics :visits, :visitbouncerate
  dimensions :date
end

class Sources
  extend Garb::Model

  metrics :visits
  dimensions :source
end

class Pages
	extend Garb::Model

	metrics :pageviews
	dimensions :pagetitle, :hostname, :page_path
end


class Pageviews
	extend Garb::Model 

	metrics :pageviews
end

class Visitors
	extend Garb::Model

	metrics :visitors
end

class Snapshot
  extend Garb::Model

  metrics :visits, :pageviews, :visitors, :visitbouncerate
end
