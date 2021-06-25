class PostsController < ApplicationController
  before_action :sign_in_required, only: [:create]

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to topic_path(session[:new_post]['topic_id']), notice: '作成に成功'
    else
      redirect_to topic_path(session[:new_post]['topic_id']), notice: '作成に失敗'
    end
  end

  def post_params
    @params = params[:post].permit(:body)
    @params["user_id"] = session[:new_post]['user_id']
    @params["topic_id"] = session[:new_post]['topic_id']
    @params
  end
end
