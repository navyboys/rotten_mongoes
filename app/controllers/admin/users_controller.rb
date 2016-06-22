class Admin::UsersController < AdminsController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
