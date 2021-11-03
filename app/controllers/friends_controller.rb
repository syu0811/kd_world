class FriendsController < ApplicationController
  before_action :sign_in_required, only: [:index, :show, :create, :destroy]
  before_action :get_friends, only: [:index]

  def index
    @user = current_user
    @friends = Friend.get_friend_list(current_user.id)
  end

  def show
    tmp = Friend.find(params[:id])
    @friend = if tmp.user_id == current_user.id
                User.find(tmp.friend_id)
              else
                User.find(tmp.user_id)
              end
  end

  def create
    @friend = Friend.new(friend_params)
    if @friend.save
      @friend_request = FriendRequest.find(params[:friend][:request_id])
      @friend_request.destroy
      redirect_to friends_path, notice: 'フレンドに追加しました。'
    else
      render :index
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    if @friend.destroy!
      redirect_to friends_path, notice: '削除に成功'
    else
      redirect_to friends_path, notice: '削除に失敗'
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:user_id, :friend_id)
  end

  def get_friends
    @friends = Friend.get_friend_list(current_user.id)
  end
end
