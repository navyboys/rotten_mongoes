class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    if session[:original_user_id]
      session[:user_id] = session[:original_user_id]
      session.delete(:original_user_id)
      flash[:notice] = 'Welcome back!'
      redirect_to admin_users_path
    else
      reset_session if current_user
      redirect_to :root, notice: 'You have been logged out.'
    end
  end
end
