class TopicsController < ApplicationController
  before_action :sign_in_required, only: [:index, :show, :new, :create]
  before_action :get_topics, only: [:index]
  before_action :get_users, only: [:new, :create]

  def show
    @topic = Topic.find(params[:id])
    @posts = Post.select_topic_posts(params[:id])
    @new_post = Post.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path, notice: '作成に成功'
    else
      render :new
    end
  end

  private

  def get_topics
    @topics = Topic.all
  end

  def get_users
    @users = User.all
  end

  def topic_params
    @params = params.require(:topic).permit(:title)
    @params[:user_id] = current_user.id
    @params
  end
end
