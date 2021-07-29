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
end
