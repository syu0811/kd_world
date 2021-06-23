require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:login_user) { create(:user) }
  let!(:topic){create(:topic)}

  before do
    sign_in login_user
  end

  describe "POST /post" do
    it "ステータス OK が返ってくる" do
      post :create, params: { body: "テスト"}
      expect(response.body).to include("作成に成功")
    end
  end
end
