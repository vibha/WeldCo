namespace :db do

  desc 'Insert Admin User'
  task :create_admin_user => :environment do 
    puts "#################################"
    user = User.create!({:email => "admin@gmail.com", :password => "admin123"})
    user.first_name = "Vibha"
    user.last_name = "Malhotra"
    user.loginId = "vibha"
    user.status = 1
    user.role = "Admin"
    user.save!
    puts "Successfully created Admin for WeldCo"
    puts "#################################"
  end

end