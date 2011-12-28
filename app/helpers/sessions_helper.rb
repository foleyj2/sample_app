module SessionsHelper
  # refactored session control using the session system
  # instead of cookes as per Exercise 9.6.2
  # http://guides.rubyonrails.org/action_controller_overview.html
  def sign_in(user)
    sign_in_session(user)
  end

  def sign_in_cookies(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_in_session(user)
    # we don't need the salt for sessions, perhaps
    session[:current_user_id] = user.id
    self.current_user = user

  end

  def current_user=(user)
    @current_user = user
  end


  def current_user
    current_user_session
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

  def deny_access #Listing 10.12
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def sign_out
    sign_out_session
  end

  def sign_out_cookies
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def sign_out_session
    # Remove the user id from the session
    self.current_user = session[:current_user_id] = nil
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
