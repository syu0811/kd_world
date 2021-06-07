class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    top_path(current_user.id)
  end

  def authenticate_admin!
    redirect_to user_path(@user) unless current_user.admin
  end

  private

    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
