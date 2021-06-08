require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:login_user) { create(:user, admin: true) }
  let(:user) { create(:user) }

  before do
    sign_in login_user
  end

  describe "/admin/users" do
    it "ステータス OK が返ってくる" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "/admin/users/:id/edit" do
    it "ステータス OK が返ってくる" do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
