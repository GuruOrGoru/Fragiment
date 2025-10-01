class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully"
  end

  def toggle_admin
    @user.update(admin: !@user.admin?)
    redirect_to admin_user_path(@user), notice: "Admin status updated"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :bio, :favorite_languages, :admin, :avatar)
  end

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
