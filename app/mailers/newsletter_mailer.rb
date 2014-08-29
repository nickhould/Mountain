class NewsletterMailer < ActionMailer::Base
  default from: "hello@mountainmetrics.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter_mailer.weekly.subject
  #
  def weekly(email)
    @greeting = "Hi"
    @locatation = generate_graph("123")
    mail to: email
  end

  private

  def generate_graph(id)
    location = "/Volumes/Macintosh HD/Code/Mountain/public/assets/#{id}.png"
    g = Gruff::Line.new
    g.title = 'Wow!  Look at this!'
    g.labels = { 0 => '5/6', 1 => '5/15', 2 => '5/24', 3 => '5/30', 4 => '6/4', 5 => '6/12', 6 => '6/21', 7 => '6/28' }
    g.data :Jimmy, [25, 36, 86, 39, 25, 31, 79, 88]
    g.write(location)
    return location
  end
end
