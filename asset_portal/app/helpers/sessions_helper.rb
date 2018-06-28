module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(uuid: session[:user_id])
    else
      nil
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
