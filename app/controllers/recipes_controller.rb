class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @user = current_user
    @steps = @recipe.steps.build
    @foods = @recipe.foods.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = @recipe.foods
    @steps = @recipe.steps
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @user = current_user
    @foods = @recipe.foods.build
    @steps = @recipe.steps.build
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update
      redirect_to recipe_path(recipe)
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

   private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_image, :memo, :user_id,
                                   foods_attributes: [:id, :recipe_id, :item, :quantity, :_destroy],
                                   steps_attributes: [:id, :recipe_id, :process, :process_image, :_destroy])
                                  # .merge(user_id: current_user.id)
  end

end
