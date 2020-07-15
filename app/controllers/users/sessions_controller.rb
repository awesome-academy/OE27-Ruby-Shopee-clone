class Users::SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      params[:session][:remember_me] == Settings.home.remember ? remember(user) : forget(user)
      flash[:success] = t "home.login.success"
      redirect_to_target_or_default root_url
    else
      flash[:danger] = t "home.login.fail"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
