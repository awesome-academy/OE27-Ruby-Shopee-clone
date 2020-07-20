class Admins::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for admin
    admins_root_path
  end
end
