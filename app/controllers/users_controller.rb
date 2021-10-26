class UsersController < ApplicationController
 before_action :redirect_root, only: :timeline

  def timeline
    @recipes = Recipe.where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).reverse_order
    @like = current_user.likes.find_by(recipe_id: @recipes.ids)
    @tags = Hashtag.all
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).reverse_order.per(9)
    if user_signed_in?
      @like = current_user.likes.find_by(recipe_id: @recipes.ids)
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
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
    @recipes = Recipe.where(id: likes).page(params[:page]).reverse_order
    @like = user.likes.find_by(recipe_id: @recipes.ids)
    @tags = Hashtag.all
    unless user == current_user
      redirect_to root_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end

end
