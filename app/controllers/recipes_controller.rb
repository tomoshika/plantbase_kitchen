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
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = @recipe.foods
    @steps = @recipe.steps
  end

  def edit
  end

  def update
  end

  def destroy
  end

   private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_image, :memo, :user_id,
                                   foods_attributes: [:id, :recipe_id, :item, :quantity, :_destroy],
                                   steps_attributes: [:id, :recipe_id, :process, :process_image, :_destroy])
                                  # .merge(user_id: current_user.id)
  end

end
