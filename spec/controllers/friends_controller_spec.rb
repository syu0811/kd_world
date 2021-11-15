require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  describe "ログインしている場合" do
    let(:login_user) { create(:user) }
    let(:friend_user) { create(:user) }
    let(:friend_list) { create(:friend, user: login_user, friend: friend_user) }

    before do
      sign_in login_user
      friend_list
    end

    describe "/friends" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    describe "/friends/:id" do
      it "ステータス OK が返ってくる" do
        get :show, params: { id: friend_list }
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST /friends" do
      let(:user) { create(:user) }
      let(:friend) { create(:user) }

      before do
        post :create, params: { friend: { user_id: user.id, friend_id: friend.id } }
      end

      it "一覧ページへリダイレクトする" do
        expect(response).to redirect_to friends_path
      end

      it "フレンドの作成に成功している" do
        expect(Friend.all.size).to eq(2)
      end
    end

    describe "DELETE /friends/:id" do
      before do
        delete :destroy, params: { id: friend_list }
      end

      it "一覧ページへリダイレクトする" do
        expect(response).to redirect_to friends_path
      end

      it "フレンドが存在しないこと" do
        expect(Friend.all.size).to eq(0)
      end
    end
  end

  describe "ログインしていない場合" do
    let(:user) { create(:user) }
    let(:friend_user) { create(:user) }
    let(:friend_list) { create(:friend, user: user, friend: friend_user) }

    before do
      friend_list
    end

    describe "/friends" do
      it "ログイン画面へリダイレクトする" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/friends/:id" do
      it "ログイン画面へリダイレクトする" do
        get :show, params: { id: friend_list }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST /friends" do
      let(:user) { create(:user) }
      let(:friend) { create(:user) }

      it "ログイン画面へリダイレクトする" do
        post :create, params: { friend: { user_id: user.id, friend_id: friend.id } }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE /friends/:id" do
      it "ログイン画面へリダイレクトする" do
        delete :destroy, params: { id: friend_list }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
