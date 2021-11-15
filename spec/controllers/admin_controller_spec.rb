require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe "管理者ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: true) }

    before do
      sign_in login_user
    end

    describe "/admin" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "一般ユーザーでログインしている場合" do
    let(:login_user) { create(:user, admin: false) }

    before do
      sign_in login_user
    end

    describe "/admin" do
      it 'ユーザページへリダイレクトすること' do
        get :index
        expect(response).to redirect_to user_path(login_user.id)
      end
    end
  end
end
