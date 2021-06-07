require 'rails_helper'

RSpec.describe TopController, type: :controller do
  describe "/top" do
    it "ステータス OK が返ってくる" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "/top/:id" do
    let(:login_user) { create(:user) }

    before do
      sign_in login_user
    end

    it "ステータス OK が返ってくる" do
      get :show, params: { id: login_user.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
