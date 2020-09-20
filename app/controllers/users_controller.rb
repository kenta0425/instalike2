class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :following, :followers]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :username, :email, :website, :profile, :sex)
    end
end
