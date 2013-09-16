class Track
  attr_accessor :events

  def initialize
    @events ||= [ ]
  end

  def track(event_name)
    events << event_name.to_s
  end

end