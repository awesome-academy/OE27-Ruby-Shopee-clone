class Users::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "home.sign_up.success"
      redirect_to root_url
    else
      flash[:danger] = t "home.sign_up.fail"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
