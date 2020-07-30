class Users::ReviewsController < ApplicationController
  before_action :logged_in_user

  def create
    @reviews = Review.create review_params
  end

  private

  def review_params
    params.require(:review).permit Review:: REVIEW_PARAMS
  end
end
