class UsersController < ApplicationController

  def timeline
    @recipes = Recipe.where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).reverse_order
    # @recipes = Recipe.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user), notice: "アカウント情報を編集しました"
    else
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def likes
    user = User.find(params[:id])
    likes = Like.where(user_id: user.id).pluck(:recipe_id)
    # @recipes = Recipe.find(likes)
    #liked_recipe_ids
    @recipes = Recipe.where(id: likes).page(params[:page]).reverse_order
  end


  private

  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end

end
