# -*- Ruby -*- 
source 'http://rubygems.org'
## update using
## bundle install
## then to setup bins
## bundle install -binstubs

gem 'rails', '3.0.11'
gem 'sqlite3', '1.3.3'
gem 'gravatar_image_tag', '1.0.0.pre2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'heroku'
      # allow SSL connections
      # Exercise 9.6.3
      #http://www.simonecarletti.com/blog/2011/05/configuring-rails-3-https-ssl/
      gem 'rack-ssl', :require => 'rack/ssl'

group :development do
      gem 'rspec-rails', '2.6.1'  # rspec tester
      gem 'annotate', '2.4.0' # shows DB schema in comments
      gem 'faker', '0.3.1' # makes realistic fake users Listing (10.24)
end
group :test do
      gem 'rspec-rails', '2.6.1'
      gem 'webrat', '0.7.1'
#     gem 'autotest', '4.4.6'
     gem 'autotest'
#     gem 'autotest-rails-pure', '4.1.2'
     gem 'autotest-rails-pure'
### something is very wrong with ffi and fsevent
### Can't find much information on the internet, aborting
#     gem 'autotest-fsevent', '0.2.4'
#     gem 'autotest-fsevent'
#     gem 'autotest-growl', '0.2.16'
      ## Use 0.2.12 on pre-lion macs
      gem 'autotest-growl', '0.2.12'
      gem 'factory_girl_rails', '1.0'
end
