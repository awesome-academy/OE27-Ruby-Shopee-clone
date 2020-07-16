class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for user
    shops_root_path
  end
end
