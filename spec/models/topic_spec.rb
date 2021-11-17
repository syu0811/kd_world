require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'Validation' do
    let(:user) { create(:user) }

    context '正常系' do
      it "成功する" do
        topic = build(:topic, user: user)
        expect(topic).to be_valid
      end
    end

    context '異常系' do
      it "titleが無ければ失敗する" do
        topic = build(:topic, title: nil)
        topic.valid?
        expect(topic.errors[:title]).to include('を入力してください')
      end

      it "user_idが無ければ失敗する" do
        topic = build(:topic, user: nil)
        topic.valid?
        expect(topic.errors[:user]).to include('を入力してください')
      end

      it "titleが30文字以内でないと失敗する" do
        topic = build(:topic, title: "a" * 31)
        topic.valid?
        expect(topic.errors[:title]).to include('は30文字以内で入力してください')
      end
    end
  end
end
