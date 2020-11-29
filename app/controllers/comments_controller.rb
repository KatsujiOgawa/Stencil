class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to "/reviews/#{@comment.review_id}"
  end
  
  
  private
  def comment_params
    # binding.pry 
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, review_id: params[:review_id])
  end

  

end