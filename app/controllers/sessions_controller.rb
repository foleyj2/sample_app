class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else # valid user
      sign_in user
      #redirect_to user
      #replaced by friendly forwarding (Listing 10.18)
      redirect_back_or user
    end
  end #create

  def destroy
    sign_out
    redirect_to root_path
  end

end
