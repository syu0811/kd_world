class FriendsController < ApplicationController
  before_action :sign_in_required, only: [:index, :show, :destroy]

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

  def destroy
    @friend = Friend.find(params[:id])
    if @friend.destroy!
      redirect_to friends_path, notice: '削除に成功'
    else
      redirect_to friends_path, notice: '削除に失敗'
    end
  end
end
