class Users::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reviews = Review.create review_params
  end

  private
  def review_params
    params.require(:review).permit Review:: REVIEW_PARAMS
  end
end
