class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :get_log_in_user, only: [:show]
  private

  def get_log_in_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :department_id)
  end
end
