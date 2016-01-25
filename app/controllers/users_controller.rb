class UsersController < ApplicationController

  skip_before_filter :authentication, only: [:new, :create]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new
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
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :birth_date, :phone )
  end
  
  def authentication
    unless current_user
      redirect_to sign_in_path
    end      
  end

end
