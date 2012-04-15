namespace :db do

  desc 'Create First Welding Company And First Admin User'
  task :create_company => :environment do 
    puts "#################################"
    company = Company.create!({:name => "WeldCo", 
                               :description => "Weldco....", :logo_title => "We create quality"})
    puts "Successfully created Company WeldCo"
    puts "#################################"
    puts "#################################"
    company.users << User.create!(:name => "Vibha Malhotra", :email => "admin@weldco.com", :password => "admin123", :role => "Admin")
    puts "Successfully created Admin of WeldCo"
    puts "#################################"
    
  end

end