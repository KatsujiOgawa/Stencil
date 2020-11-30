class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :stranger_prevent, only: [:edit, :destroy]
  def about

  end

  def top
  end

  def index
    @reviews = Review.all.order(created_at: :DESC)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.includes(:user)
  end
  

  private
  def review_params
    params.require(:review).permit(:title, :image, :text, :category_id, :limit_id).merge(user_id: current_user.id)
  end
   
  def set_review
    @review = Review.find(params[:id])
  end

  def stranger_prevent
    unless @review.user == current_user
      redirect_to root_path
    end
  end

end

