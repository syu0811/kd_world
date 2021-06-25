require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:login_user) { create(:user) }
  let(:topic) { create(:topic) }

  before do
    sign_in login_user
    topic
  end

  describe "POST /post" do
    it "リクエストが成功する" do
      session[:new_post] = Post.new
      session[:new_post][:user_id] = login_user.id
      session[:new_post][:topic_id] = topic.id
      post :create, params: { body: "テスト" }
      expect(response.status).to eq 302
    end

    it 'postが登録されること' do
      session[:new_post] = Post.new
      session[:new_post][:user_id] = login_user.id
      session[:new_post][:topic_id] = topic.id
      expect { post :create, params: { body: "テスト" } }.to change(Post, :count).by(1)
    end
  end
end
