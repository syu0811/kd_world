require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Validation' do
    let(:user) { create(:user) }
    let(:applicant) { create(:user) }
    let(:friend_user) { create(:user) }

    before do
      create(:friend, user: applicant, friend: friend_user)
    end

    context '正常系' do
      it "成功する" do
        request = build(:friend_request, user: user, applicant: applicant)
        expect(request).to be_valid
      end
    end

    context '異常系' do
      it "userが無ければ失敗する" do
        request = build(:friend_request, user: nil, applicant: applicant)
        request.valid?
        expect(request.errors[:user]).to include('を入力してください')
      end

      it "friendが無ければ失敗する" do
        request = build(:friend_request, user: user, applicant: nil)
        request.valid?
        expect(request.errors[:applicant]).to include('を入力してください')
      end

      it "userとfriendが同じ値だったら失敗する" do
        request = build(:friend_request, user: user, applicant: user)
        request.valid?
        expect(request.errors[:user]).to include('自分に申請することはできません。')
      end

      it "申請先がすでにフレンド登録されていたら失敗する" do
        request = build(:friend_request, user: friend_user, applicant: applicant)
        request.valid?
        expect(request.errors[:user]).to include('すでに登録済みのユーザーに申請することはできません。')
      end
    end
  end
end
