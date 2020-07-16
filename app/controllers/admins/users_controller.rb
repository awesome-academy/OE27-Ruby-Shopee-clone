class Admins::UsersController < AdminsController
  before_action :load_user, except: :index

  def index
    @users = User.with_deleted
      .order_by_deleted
      .page(params[:page])
      .per Settings.admin.per_page
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.delete_user_success"
    else
      flash[:danger] = t "admin.deleted_user_fail"
    end
    redirect_to admins_root_path
  end

  def restore
    if @user.restore
      flash[:success] = t "admin.restore_user_success"
    else
      flash[:danger] = t "admin.restore_user_fail"
    end
    redirect_to admins_root_path
  end

  private

  def load_user
    @user = User.with_deleted.find_by id: params[:id]
    return if @user

    flash[:danger] = t "admin.user_not_exist"
    redirect_to admins_root_path
  end
end
