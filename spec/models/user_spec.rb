require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    let(:department) { create(:department) }

    context '正常系' do
      it "成功する" do
        user = build(:user, department: department)
        expect(user).to be_valid
      end
    end

    context '異常系' do
      it "nameが無ければ失敗する" do
        user = build(:user, name: nil, department: department)
        user.valid?
        expect(user.errors[:name]).to include('が入力されていません。')
      end

      it "emailが無ければ失敗する" do
        user = build(:user, email: nil, department: department)
        user.valid?
        expect(user.errors[:email]).to include('が入力されていません。')
      end

      it "emailがKDアカウントでなければ失敗する" do
        user = build(:user, email: "aaa@example.com", department: department)
        user.valid?
        expect(user.errors[:email]).to include('は有効でありません。')
      end

      it "passwordが6文字以上ないと失敗する" do
        user = build(:user, password: "a", department: department)
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上に設定して下さい。')
      end

      it "passwordがpassword_confirmationと同一でないと失敗する" do
        user = build(:user, password: "password", password_confirmation: "passworld", department: department)
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end
  end
end
