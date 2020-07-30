class Users::RatingsController < ApplicationController
  before_action :logged_in_user

  def create
    rate = Rating.create star: params[:star], product_id: params[:product_id],
      user_id: current_user.id

    respond_to :js
  end
end
