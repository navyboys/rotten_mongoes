class Admin::SessionsController < AdminsController
  def impersonate
    flash[:notice] = "Welcome to user (id: #{params[:id]})'s account."
    session[:original_user_id] = session[:user_id]
    session[:user_id] = params[:id]
    redirect_to root_path
  end
end
