class ShopsController < ApplicationController
  layout "shops"

  def check_login
    return if logger_in?
    flash[:warning] = t "home.login.require"
    redirect_to login_path
  end
end
