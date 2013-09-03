namespace :update do
  task :blogs => :environment do |t|
    User.all.each do |user|
      auth = user.authorization_from_tumblr
        auth.create_all_blogs_from_tumblr if auth
    end
  end
end

