class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new_guest]
  
  def show
    @guest_user = User.guest
    @user = User.find(params[:id])
    
    # binding.pry
  end

 

  def new_guest
    @guest_user = User.guest
    sign_in @guest_user
    redirect_to root_path
  end


end
