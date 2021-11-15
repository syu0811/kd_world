require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "ログインしている場合" do
    let(:login_user) { create(:user) }

    before do
      sign_in login_user
    end

    describe "/users/:id" do
      it "ステータス OK が返ってくる" do
        get :show, params: { id: login_user.id }
        expect(response).to have_http_status(:ok)
      end

      it "userが取得できているか" do
        get :show, params: { id: login_user.id }
        expect(response.body).to include(login_user.name)
      end
    end
  end

  describe "ログインしていない場合" do
    let(:user) { create(:user) }

    describe "/users/:id" do
      it "ログイン画面へリダイレクトする" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
