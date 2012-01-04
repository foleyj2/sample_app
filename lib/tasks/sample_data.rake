# -*- Ruby -*-
namespace :db do
  testusers = 100
  desc "Fill database with sample data"
  task :populate => :environment do  # get access to rails env
    Rake::Task['db:reset'].invoke
    admin = User.create(:name => "Example User",
                :email => "example@railstutorial.org",
                :password => "foobar",
                :password_confirmation => "foobar")
    admin.toggle!(:admin) # Listing 10.36, can't access it in the assignment
    testusers -= 1
    testusers.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end # each testuser
  end # :populate
end # namespace :db
