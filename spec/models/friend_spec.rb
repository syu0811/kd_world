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

  describe ".get_friend_list_ids_array" do
    let(:user) { create_list(:user, 3) }

    before do
      create(:friend, user: user[0], friend: user[2])
      create(:friend, user: user[1], friend: user[0])
    end

    context '全てのフレンドが取得できているか' do
      it '指定したユーザーのフレンドのidリストが取得できているか' do
        expect(described_class.get_friend_list_ids_array(user[0].id)).to include(user[1].id)
      end

      it '指定したユーザーのフレンドのidリストが昇順に取得できているか' do
        expect(described_class.get_friend_list_ids_array(user[0].id)).to match [user[1].id, user[2].id]
      end
    end

    context 'フレンドではないユーザーが含まれていないか' do
      it '指定したユーザーのフレンドのidがリストに含んでいないか' do
        expect(described_class.get_friend_list_ids_array(user[1].id)).not_to include(user[2].id)
      end
    end
  end

  describe ".get_friend_list" do
    let(:user) { create_list(:user, 3) }

    before do
      create(:friend, user: user[0], friend: user[2])
      create(:friend, user: user[1], friend: user[0])
    end

    context '全てのフレンドが取得できているか' do
      it '指定したユーザーのフレンドのidリストが取得できているか' do
        expect(described_class.get_friend_list(user[0].id)).to include(user[1])
      end

      it '指定したユーザーのフレンドがidの昇順に取得できているか' do
        expect(described_class.get_friend_list(user[0].id)).to match [user[1], user[2]]
      end
    end

    context 'フレンドではないユーザーが含まれていないか' do
      it '指定したユーザーのフレンドがリストに含んでいないか' do
        expect(described_class.get_friend_list_ids_array(user[1].id)).not_to include(user[2])
      end
    end
  end

  describe ".get_friend_table_id" do
    let(:user) { create(:user) }
    let(:friend_user) { create(:user) }
    let(:friend_list) { create(:friend, user: user, friend: friend_user) }

    before do
      friend_list
    end

    context '指定したユーザーidの組み合わせでfriendテーブルのidを検索する' do
      it '正しいidのデータが帰ってくる' do
        expect(described_class.get_friend_table_id(user.id, friend_user.id)).to include(friend_list)
      end

      it 'データが１件のみであること' do
        expect(described_class.get_friend_table_id(user.id, friend_user.id).size).to eq(1)
      end
    end
  end
end
