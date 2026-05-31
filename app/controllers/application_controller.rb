class ApplicationController < ActionController::Base
  before_action :require_login

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to continue."
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to dashboard_path, alert: "Admin access required."
    end
  end
end
