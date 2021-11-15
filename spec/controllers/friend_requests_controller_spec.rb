require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  describe "ログインしている場合" do
    let(:login_user) { create(:user) }
    let(:user) { create(:user) }

    before do
      sign_in login_user
    end

    describe "/friend_requests" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    describe "/friend_requests/:id" do
      it "ステータス OK が返ってくる" do
        get :show, params: { id: login_user }
        expect(response).to have_http_status(:ok)
      end
    end

    describe "/friend_requests/new" do
      it "ステータス OK が返ってくる" do
        get :new
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST /friend_requests" do
      before do
        post :create, params: { friend_request: { user_id: user.id, applicant_id: login_user.id } }
      end

      it "一覧ページへリダイレクトする" do
        expect(response).to redirect_to friend_requests_path
      end

      it "リクエストの作成が成功している" do
        expect(FriendRequest.all.count).to eq(1)
      end
    end

    describe "DELETE /friend_requests/:id" do
      let(:friend_request) { create(:friend_request) }

      before do
        delete :destroy, params: { id: friend_request.id }
      end

      it "リクエストの削除が成功している" do
        expect(FriendRequest.all).to be_empty
      end
    end
  end

  describe "ログインしていない場合" do
    describe "/friend_requests" do
      it "ログイン画面へリダイレクトする" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/friend_requests/:id" do
      let(:user) { create(:user) }

      it "ログイン画面へリダイレクトする" do
        get :show, params: { id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/friend_requests/new" do
      it "ログイン画面へリダイレクトする" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST /friend_requests" do
      let(:user) { create(:user) }
      let(:applicant) { create(:user) }

      it "ログイン画面へリダイレクトする" do
        post :create, params: { friend_request: { user_id: user.id, applicant_id: applicant.id } }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE /friend_requests/:id" do
      let(:friend_request) { create(:friend_request) }

      it "ログイン画面へリダイレクトする" do
        delete :destroy, params: { id: friend_request.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
