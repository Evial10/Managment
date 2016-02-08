class UsersController < ApplicationController

  before_filter :authentication
  skip_before_filter :authentication, :only => [:new, :create]
  after_action :verify_authorized, only: [:destroy]
  rescue_from Pundit::NotAuthorizedError, with: :not_admin

  def index
    @users = policy_scope(User)
  end
  
  def show    
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new  
    authorize @user   
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])    
  end
  
  def update
    @user = User.find(params[:id])
    @user.remove_avatar! if params[:user][:remove_avatar]    
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy    
    redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :birth_date, :phone, :trainee, :admin, :avatar )
  end
  
  def authentication  
    unless current_user  
      redirect_to sign_in_path 
    end          
  end 
  
  def not_admin
    redirect_to users_path
  end
  

end
