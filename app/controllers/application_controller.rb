class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper  #to the rescue!
end
