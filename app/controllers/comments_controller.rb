class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    recipe_comment = current_user.comments.new(comment_params)
    recipe_comment.recipe_id = @recipe.id
    recipe_comment.save
    redirect_to recipe_path(recipe)
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:recipe_comment)
  end

end
