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

      it "applicantが無ければ失敗する" do
        request = build(:friend_request, user: user, applicant: nil)
        request.valid?
        expect(request.errors[:applicant]).to include('を入力してください')
      end

      it "userとapplicantが同じ値だったら失敗する" do
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

  describe ".get_request_user_list" do
    let(:user) { create(:user) }
    let(:applicant) { create_list(:user, 2) }
    let(:target) { create(:friend_request, user: user, applicant: applicant[0]) }
    let(:not_target) { create(:friend_request, user: user, applicant: applicant[1]) }

    context "指定したリクエストが全て取得できているか" do
      it "指定した申請者の申請したリクエストが取得できているか" do
        expect(described_class.get_request_user_list(applicant[0].id)).to include(target)
      end
    end

    context "指定したリクエスト以外を含んでいないか" do
      it "指定した申請者の申請したリクエスト以外を取得していないか" do
        expect(described_class.get_request_user_list(applicant[0].id)).not_to include(not_target)
      end

      it "指定していない申請者の申請したリクエストを含んでいないか" do
        expect(described_class.get_request_user_list(applicant[1].id)).not_to include(target)
      end
    end
  end

  describe ".get_request_pending_user_list" do
    let(:user) { create_list(:user, 2) }
    let(:applicant) { create(:user) }
    let(:target) { create(:friend_request, user: user[0], applicant: applicant) }
    let(:not_target) { create(:friend_request, user: user[1], applicant: applicant) }

    context "指定したリクエストが全て取得できているか" do
      it "指定したユーザーに申請したリクエストが取得できているか" do
        expect(described_class.get_request_pending_user_list(user[0].id)).to include(target)
      end
    end

    context "指定したリクエスト以外を含んでいないか" do
      it "指定したユーザーに申請したリクエスト以外を取得していないか" do
        expect(described_class.get_request_pending_user_list(user[0].id)).not_to include(not_target)
      end

      it "指定していないユーザーに申請したリクエストを含んでいないか" do
        expect(described_class.get_request_pending_user_list(user[1].id)).not_to include(target)
      end
    end
  end

  describe ".get_user_random_list" do
    let!(:user) { create(:user) }
    let(:friend_user) { create(:user) }

    before do
      create_list(:user, 11)
      create(:friend, user: user, friend: friend_user)
    end

    context "含まれるべきもの" do
      it "取得件数が10件である" do
        expect(described_class.get_user_random_list(user.id).size).to eq(10)
      end

      it "戻り値の配列がランダムに並び替えられている" do
        value = described_class.get_user_random_list(user.id)
        tmp = described_class.get_user_random_list(user.id)
        expect(tmp).not_to match_array(value)
      end
    end

    context "含まれるべきではないもの" do
      it "取得件数が10件を超える" do
        expect(described_class.get_user_random_list(user.id).size).not_to be > 10
      end

      it "フレンドユーザーが含まれていない" do
        expect(described_class.get_user_random_list(user.id)).not_to include(friend_user)
      end
    end
  end

  describe ".delete_request_users_and_friends" do
    let(:user) { create_list(:user, 2) }
    let(:applicant) { create(:user) }
    let!(:target) { create(:friend_request, user: user[0], applicant: applicant) }
    let!(:not_target) { create(:friend_request, user: user[1], applicant: applicant) }

    context "消えていること" do
      it "指定したリクエストが削除されているか" do
        described_class.delete_request_users_and_friends(user[0].id, applicant.id)
        expect(described_class.all).not_to include(target)
      end
    end

    context "消えていないこと" do
      it "指定したリクエスト以外が削除されていないか" do
        described_class.delete_request_users_and_friends(user[0].id, applicant.id)
        expect(described_class.all).to include(not_target)
      end
    end
  end
end
