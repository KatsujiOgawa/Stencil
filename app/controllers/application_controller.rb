class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_hurry

  def get_hurry
    if user_signed_in?    
      @last_review = Review.where(user_id: current_user.id).last
      base_date = @last_review.created_at
      days = 86400 * @last_review.limit_id
      @limit_date = base_date + days

    end
  end

private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
