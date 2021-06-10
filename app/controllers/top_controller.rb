class TopController < ApplicationController
  before_action :sign_in_required, only: [:show]
  before_action :attribute_log_in_user, only: [:show]
  def index
  end

  def show
  end

  private

  def attribute_log_in_user
    @user = current_user
  end
end
