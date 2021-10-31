class FriendRequestsController < ApplicationController
  before_action :sign_in_required, only: [:index, :new, :create, :delete]

  def index
    @requests = FriendRequest.get_request_user_list(current_user.id)
  end

  def show
    @users = FriendRequest.get_request_pending_user_list(current_user.id)
  end

  def new
    @name = params[:name]
    @friend_request = FriendRequest.new
    @pending = FriendRequest.get_request_user_list(current_user.id)
    @users = if @name.nil?
               FriendRequest.get_user_list(current_user.id)
             else
               FriendRequest.get_user_list(current_user.id).where(name: @name)
             end
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    if @friend_request.save
      redirect_to friend_requests_path, notice: '作成に成功'
    else
      render :new
    end
  end

  protected

  def friend_request_params
    @params = params.require(:friend_request).permit(:user_id, :applicant_id)
  end
end
