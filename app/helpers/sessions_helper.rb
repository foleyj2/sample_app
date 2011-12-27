module SessionsHelper
  # http://guides.rubyonrails.org/action_controller_overview.html
  def sign_in(user)
    sign_in_cookies(user)
  end

  def sign_in_cookies(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_in_session(user)
    session[:remember_token] = [user.id, user.salt]
    #session[:user] = user
    self.current_user = user

    session[:current_user_id] = user.id
    redirect_to root_url
  end

  def current_user=(user)
    @current_user = user
  end


  def current_user
    current_user_cookies
  end

  def current_user_cookies
    @current_user ||= user_from_remember_token
  end

  def current_user_session
    @current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    sign_out_cookies
  end

  def sign_out_cookies
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def sign_out_session
    # Remove the user id from the session
    @current_user = session[:current_user_id] = nil
    redirect_to root_url
  end
  
private
  
  def user_from_remember_token
    # * takes arrays as argument and unpacks into parameters
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
