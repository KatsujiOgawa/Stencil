class ReviewsController < ApplicationController
  def top
  end

  def index
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end
  

  private
  def review_params
    params.require(:review).permit(:title, :image, :text, :category_id, :limit_id).merge(user_id: current_user.id)
  end
end
