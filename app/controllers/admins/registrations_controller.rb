class Admins::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for admin
    admins_root_path
  end
end
