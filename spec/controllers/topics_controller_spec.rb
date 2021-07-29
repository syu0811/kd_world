require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "ログインしている場合" do
    let!(:topic) { create(:topic) }
    let(:login_user) { create(:user) }

    before do
      sign_in login_user
    end

    describe "/topics" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "topicが取得できているか" do
        get :index
        expect(response.body).to include(topic.title)
      end
    end

    describe "/topics/:id" do
      it "ステータス OK が返ってくる" do
        get :show, params: { id: topic.id }
        expect(response).to have_http_status(:ok)
      end

      it "topicが取得できているか" do
        get :show, params: { id: topic.id }
        expect(response.body).to include(topic.title)
      end
    end

    describe "/topics/new" do
      it "ステータス OK が返ってくる" do
        get :new
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ログインしていない場合" do
    let(:topic) { create(:topic) }

    describe "/topics" do
      it "ログイン画面へリダイレクトする" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/topics/:id" do
      it "ステータス OK が返ってくる" do
        get :show, params: { id: topic.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/topics/new" do
      it "ステータス OK が返ってくる" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
