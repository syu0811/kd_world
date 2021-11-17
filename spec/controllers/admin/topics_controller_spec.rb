require 'rails_helper'

RSpec.describe Admin::TopicsController, type: :controller do
  let!(:topic) { create(:topic) }

  describe "管理者ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: true) }

    before do
      sign_in login_user
    end

    describe "/admin/topics" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "topicが取得できているか" do
        get :index
        expect(response.body).to include(topic.title)
      end
    end

    describe "/admin/topics/:id" do
      it "ステータス OK が返ってくる" do
        delete :destroy, params: { id: topic.id }
        expect(response).to redirect_to(admin_topics_path)
      end
    end
  end

  describe "一般ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: false) }

    before do
      sign_in login_user
    end

    describe "/admin/topics" do
      it 'ユーザページへリダイレクトすること' do
        get :index
        expect(response).to redirect_to user_path(login_user.id)
      end
    end

    describe "/admin/topics/:id" do
      it "ステータス OK が返ってくる" do
        delete :destroy, params: { id: topic.id }
        expect(response).to redirect_to user_path(login_user.id)
      end
    end
  end
end
