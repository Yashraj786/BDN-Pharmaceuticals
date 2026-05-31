class SettingsController < ApplicationController
  before_action :require_admin

  def index
    @users = User.order(:name)
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to settings_path, notice: "User #{@user.name} added successfully!"
    else
      render :new_user, status: :unprocessable_entity
    end
  end

  def destroy_user
    user = User.find(params[:id])
    if user == current_user
      redirect_to settings_path, alert: "You cannot delete yourself."
    else
      user.destroy
      redirect_to settings_path, notice: "User removed."
    end
  end

  def change_password
    user = current_user
    if user.authenticate(params[:current_password])
      if user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
        redirect_to settings_path, notice: "Password changed successfully!"
      else
        redirect_to settings_path, alert: "New password is invalid. Minimum 4 characters."
      end
    else
      redirect_to settings_path, alert: "Current password is wrong."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :role, :password, :password_confirmation)
  end
end
