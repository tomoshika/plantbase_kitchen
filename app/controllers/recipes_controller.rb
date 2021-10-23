class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @steps = @recipe.steps.build
    @foods = @recipe.foods.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました"
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.page(params[:page]).reverse_order.per(10)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @foods = @recipe.foods
    @steps = @recipe.steps
    @user = @recipe.user
    @like = current_user.likes.find_by(recipe_id: @recipe.id)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @user = current_user
    @foods = @recipe.foods.build
    @steps = @recipe.steps.build
    unless @recipe.user == current_user
      redirect_to recipes_path
    end
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      redirect_to recipe_path(recipe), notice: "レシピを編集しました"
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to user_path(current_user), notice: "レシピを削除しました"
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @recipes = @tag.recipes
  end

   private

  def recipe_params
    params.require(:recipe).permit(:id, :title, :recipe_image, :memo,
                                   foods_attributes: [:id, :recipe_id, :item, :quantity, :_destroy],
                                   steps_attributes: [:id, :recipe_id, :process, :process_image, :_destroy])
  end

end
