class PostsController < ApplicationController
  before_action :sign_in_required, only: [:create]

  def create
    @params = post_params
    @post = Post.new(user_id: current_user.id, topic_id: @params[:topic_id], body: @params[:body])
    if @post.save
      redirect_to topic_path(@params[:topic_id]), notice: '作成に成功'
    else
      redirect_to topic_path(@params[:topic_id]), notice: '作成に失敗'
    end
  end

  def post_params
    @params = params[:post].permit(:body, :topic_id)
  end
end
