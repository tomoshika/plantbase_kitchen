class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.recipe_id = params[:recipe_id]
    @comment.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    comment = Comment.find(params[:id])
    comment.destroy
    # redirect_to recipe_path(comment.recipe_id), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:recipe_comment)
  end
end
