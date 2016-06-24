class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def require_user
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_impersonating?
    session[:original_user_id] != nil
  end

  def current_impersonator
    User.find(session[:original_user_id])
  end

  helper_method :current_user
  helper_method :current_impersonator
  helper_method :is_impersonating?
end
