class Admin::UsersController < AdminsController
  before_filter :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User created!"
    else
      render :new
    end
  end

  def update
    binding.pry
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "User updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    UserMailer.delete_notification_email(@user).deliver_now
    redirect_to admin_users_path, notice: "User deleted."
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
