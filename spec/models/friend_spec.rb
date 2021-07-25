require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'Validation' do
    let(:user) { create(:user) }
    let(:friend_user) { create(:user) }

    context '正常系' do
      it "成功する" do
        friend = build(:friend, user: user, friend: friend_user)
        expect(friend).to be_valid
      end
    end

    context '異常系' do
      it "userが無ければ失敗する" do
        friend = build(:friend, user: nil, friend: friend_user)
        friend.valid?
        expect(friend.errors[:user]).to include('を入力してください')
      end

      it "friendが無ければ失敗する" do
        friend = build(:friend, user: user, friend: nil)
        friend.valid?
        expect(friend.errors[:friend]).to include('を入力してください')
      end

      it "userとfriendが同じ値だったら失敗する" do
        friend = build(:friend, user: user, friend: user)
        friend.valid?
        expect(friend.errors[:user]).to include('同じユーザーがフレンドになることはできません。')
      end
    end
  end
end
