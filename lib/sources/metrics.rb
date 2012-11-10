class Exits
  extend Garb::Model

  metrics :exits, :pageviews
  dimensions :page_path
end


class Visits
  extend Garb::Model

  metrics :visits
end

class Page
  extend Garb::Model

  dimensions :pageTitle
  metrics :pageviews  
end