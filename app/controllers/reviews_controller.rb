class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def about

  end

  def top
  end

  def index
    @reviews = Review.all
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

  def show
  end
  

  private
  def review_params
    params.require(:review).permit(:title, :image, :text, :category_id, :limit_id).merge(user_id: current_user.id)
  end
   
  def set_review
    @review = Review.find(params[:id])
  end

end

