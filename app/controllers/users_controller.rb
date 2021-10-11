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
    @user.update(user_params)
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end

end
