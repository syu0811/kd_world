class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :attribute_log_in_user, only: [:show, :edit, :update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: t('flash.update')
    else
      render :edit
    end
  end

  private

    def attribute_log_in_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
