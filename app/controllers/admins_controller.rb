class AdminsController < ApplicationController
  before_action :require_user
  before_action :require_admin

  private

  def require_admin
    if !current_user.admin?
      redirect_to root_path, alert: 'You are not authorized to do that'
    end
  end
end
