class UserSessionsController < ApplicationController
  
  rescue_from Pundit::NotAuthorizedError, with: :user_authorized
  
  def new 
    @user_session = UserSession.new
    authorize @user_session
  end
  
  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      redirect_to users_path
    else  
      render 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_to root_path
  end
  
  private
  
  def user_authorized
    redirect_to users_path
  end
  
  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end

end
