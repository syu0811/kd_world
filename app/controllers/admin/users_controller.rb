module Admin
  class UsersController < ApplicationController
    before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy]
    before_action :get_users_list, only: [:index]
    before_action :get_log_in_user, only: [:index]
    before_action :get_departments, only: [:edit]
    before_action :get_user, only: [:show, :edit, :update, :destroy]

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: t('flash.create')
      else
        redirect_to admin_users_path, notice: "登録に失敗しました"
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: t('flash.update')
      else
        redirect_to admin_users_path, notice: "更新に失敗しました"
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t('flash.destroy')
    end

    private

    def get_users_list
      @users = User.all.where.not(id: current_user.id)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def get_log_in_user
      @log_in_user = current_user
    end

    def get_departments
      @departments = Department.all
    end

    def user_params
      params.require(:user).permit(:name, :email, :department_id, :admin)
    end
  end
end
