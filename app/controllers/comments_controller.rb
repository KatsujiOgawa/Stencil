class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destoroy]
  def create
    @comment = Comment.create(comment_params)
    redirect_to "/reviews/#{@comment.review_id}"
  end
  
  def destroy
    @comment = Comment.find(params[:review_id])
    @comment.destroy
    redirect_to review_path(@comment.review)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, review_id: params[:review_id])
  end

  

end