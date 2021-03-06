
class Exits
  extend Garb::Model

  metrics :exits
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
  dimensions :page_path
end

class Visitors
	extend Garb::Model

	metrics :visitors
end
  
class Snapshot
  extend Garb::Model

  metrics :visits, :pageviews, :visitors, :visitbouncerate, :avgTimeOnSite
end

class Snapshotperpage
  extend Garb::Model

  metrics :visits, :pageviews, :visitors, :visitbouncerate
  dimensions :page_path
end

class Nextpage
  extend Garb::Model

  metrics :pageviews
  dimensions :page_path, :pagetitle 
end

class Keywords
  extend Garb::Model

  metrics :visits
  dimensions :keyword
end

class Mobile
  extend Garb::Model

  metrics :visits
  dimensions :isMobile
end

