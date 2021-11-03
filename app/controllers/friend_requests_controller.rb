class FriendRequestsController < ApplicationController
  before_action :sign_in_required, only: [:index, :new, :create, :destroy]

  def index
    @requests = FriendRequest.get_request_user_list(current_user.id)
  end

  def show
    @users = FriendRequest.get_request_pending_user_list(current_user.id)
  end

  def new
    @friend_request = FriendRequest.new
    @pending = FriendRequest.get_request_user_list(current_user.id).pluck(:user_id)
    @users = if params[:name].nil?
               FriendRequest.get_user_random_list(current_user.id)
             else
               FriendRequest.get_user_random_list(current_user.id).where(name: params[:name])
             end
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    if @friend_request.save
      redirect_to friend_requests_path, notice: '申請しました。'
    else
      render :new
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.destroy!
      redirect_to friend_request_path(current_user), notice: '申請を取り消しました。'
    else
      redirect_to friend_request_path(current_user), notice: '申請の削除に失敗しました。管理者にお問い合わせください。'
    end
  end

  protected

  def friend_request_params
    @params = params.require(:friend_request).permit(:user_id, :applicant_id)
  end
end
