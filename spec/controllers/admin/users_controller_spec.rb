require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe "管理者ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: true) }

    before do
      sign_in login_user
    end

    describe "/admin/users" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "userが取得できているか" do
        get :index
        expect(response.body).to include(user.name)
      end
    end

    describe "/admin/users/:id/edit" do
      it "ステータス OK が返ってくる" do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end

      it "userが取得できているか" do
        get :edit, params: { id: user.id }
        expect(response.body).to include(user.name)
      end
    end

    describe "/admin/users/:id" do
      it "ステータス OK が返ってくる" do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to(admin_users_path)
      end
    end
  end

  describe "一般ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: false) }

    before do
      sign_in login_user
    end

    describe "/admin/users" do
      it 'ユーザページへリダイレクトすること' do
        get :index
        expect(response).to redirect_to user_path(login_user.id)
      end
    end

    describe "/admin/users/:id/edit" do
      it "ステータス OK が返ってくる" do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to user_path(login_user.id)
      end
    end

    describe "/admin/users/:id" do
      it "ステータス OK が返ってくる" do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to user_path(login_user.id)
      end
    end
  end
end
