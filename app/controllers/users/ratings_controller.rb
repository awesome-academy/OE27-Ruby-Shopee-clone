class Users::RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    rate = Rating.create star: params[:star], product_id: params[:product_id],
      user_id: current_user.id
    respond_to :js
  end
end
