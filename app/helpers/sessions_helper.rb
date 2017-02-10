helpers do

  def logged_in?
    current_user != nil
  end

  def current_user
     @_current ||= User.find_by(id: session[:user_id])
  end

  def set_user(user)
    session[:user_id] = user.id
  end

end
