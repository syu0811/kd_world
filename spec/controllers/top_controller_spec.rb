require 'rails_helper'

RSpec.describe TopController, type: :controller do
  describe "ログインしている場合" do
    let(:login_user) { create(:user) }

    before do
      sign_in login_user
    end

    describe "/top" do
      it "ステータス OK が返ってくる" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ログインしていない場合" do
    describe "/top" do
      it "ログイン画面へリダイレクトする" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
