class AdminsController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource

  protect_from_forgery

  layout "admins"

  rescue_from CanCan::AccessDenied do
    flash[:danger] = t "admin.access_deny"
    redirect_to admins_root_path
  end

  protected

  def current_ability
    @current_ability ||= Ability.new current_admin
  end
end
