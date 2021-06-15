module Admin
  class TopicsController < ApplicationController
    before_action :authenticate_admin!, only: [:index, :destroy]
    before_action :sign_in_required, only: [:index, :destroy]
    before_action :get_topics, only: [:index]
    before_action :get_topic, only: [:show, :destroy]

    def destroy
      @topic.destroy!
      redirect_to admin_topics_path, notice: '削除に成功'
    end

    protected

    def get_topics
      @topics = Topic.all
    end

    def get_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title)
    end
  end
end
