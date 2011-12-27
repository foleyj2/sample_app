class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  # exercise 3.5.1
  def help
    @title = "Help"
  end

end
