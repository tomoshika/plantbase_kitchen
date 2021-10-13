class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "アカウント情報を編集しました"
    else
      render :edit
    end
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end

end
