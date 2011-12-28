class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page]) # Listing 10.28
  end

  def show
    @user = User.find(params[:id]) 
    @title = @user.name
  end #show

  def new
    @user = User.new
    @title = "Sign up"
  end #new

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      ## Exercise 8.6.2
      ## Blank out the passwords on failure
      @user.password = nil
      render 'new'
    end
  end #create

  def edit
    # don't need from Listing 10.14
    # @user = User.find(params[:id])
    @title = "Edit user"
  end #edit

  def update # Listing 10.9
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end #update

  #################################################
  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user  # Listing 10.14
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
