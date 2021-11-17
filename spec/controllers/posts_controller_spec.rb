require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "ログインしている場合" do
    let!(:login_user) { create(:user) }
    let(:topic) { create(:topic) }

    before do
      sign_in login_user
      topic
    end

    describe "POST /post" do
      it "リクエストが成功する" do
        post :create, params: { post: { topic_id: topic.id, body: "テスト" } }
        expect(response.status).to eq 302
      end

      it 'postが登録されること' do
        post :create, params: { post: { topic_id: topic.id, body: "テスト" } }
        expect(Post.all.size).to eq(1)
      end
    end
  end

  describe "ログインしていない場合" do
    let(:topic) { create(:topic) }

    describe "POST /post" do
      it "ログイン画面へリダイレクトする" do
        post :create, params: { post: { topic_id: topic.id, body: "テスト" } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
