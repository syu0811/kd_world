require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:login_user) { create(:user) }

  describe "/users/:id" do
    before do
      sign_in login_user
    end

    it "ステータス OK が返ってくる" do
      get :show, params: { id: login_user.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
