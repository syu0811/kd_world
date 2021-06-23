class TopicsController < ApplicationController
  before_action :sign_in_required, only: [:index, :show, :new, :create]
  before_action :get_topics, only: [:index]
  before_action :get_users, only: [:new, :create]
  before_action :get_topic, only: [:show]
  before_action :get_posts, only: [:show]
  before_action :set_new_post, only: [:show]

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

  protected

  def get_topics
    @topics = Topic.all
  end

  def get_users
    @users = User.all
  end

  def get_topic
    @topic = Topic.find(params[:id])
  end

  def get_posts
    @posts = Post.select_topic_posts(params[:id])
  end

  def set_new_post
    @new_post = Post.new(topic_id: params[:id], user_id: current_user.id)
  end

  def topic_params
    @params = params.require(:topic).permit(:title)
    @params[:user_id] = current_user.id
    @params
  end
end
