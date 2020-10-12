class ShopsController < ApplicationController
  before_action :authenticate_user!
  layout "shops"

  rescue_from CanCan::AccessDenied do
    flash[:danger] = t "admin.access_deny"
    redirect_to shops_products_path
  end

  protected

  def current_ability
    @current_ability ||= Ability.new current_user
  end
end
