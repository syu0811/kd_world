require 'rails_helper'

RSpec.describe TopController, type: :controller do
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
