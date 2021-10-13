class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.recipe_id = params[:recipe_id]
    if @comment.save
     redirect_to recipe_path(@comment.recipe_id), notice: "コメントを保存しました"
    else
     redirect_to request.referer
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to recipe_path(comment.recipe_id), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:recipe_id, :recipe_comment)
  end

end
