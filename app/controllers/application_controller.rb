class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_hurry

  def get_hurry
    if user_signed_in?
      @last_reviews = Review.where(user_id: current_user.id).order(created_at: :desc).limit(1)
    end
  end

private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
