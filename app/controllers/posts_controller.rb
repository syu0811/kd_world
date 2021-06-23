class PostsController < ApplicationController
  before_action :sign_in_required, only: [:create]

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to topic_path(params[:post]['topic_id']), notice: '作成に成功'
    else
      redirect_to topic_path(params[:post]['topic_id']), notice: '作成に失敗'
    end
  end

  protected

  def post_params
    params.require(:post).permit(:body, :topic_id, :user_id)
  end
end
