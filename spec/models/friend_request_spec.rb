require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Validation' do
    let(:user) { create(:user) }
    let(:applicant) { create(:user) }

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
    end
  end
end
