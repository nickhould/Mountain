namespace :update do
  task :blogs => :environment do |t|
    User.update_blogs
  end
end

