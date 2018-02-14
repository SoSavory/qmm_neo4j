class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = "Credentials Invalid"
      redirect_to '/'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to '/'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
