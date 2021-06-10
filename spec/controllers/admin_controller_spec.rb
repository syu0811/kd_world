require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe "/admin" do
    let(:login_user) { create(:user, admin: true) }

    before do
      sign_in login_user
    end

    it "ステータス OK が返ってくる" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
