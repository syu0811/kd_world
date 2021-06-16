require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validation' do
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }

    context '正常系' do
      it "成功する" do
        post = build(:post, user: user, topic: topic)
        expect(post).to be_valid
      end
    end

    context '異常系' do
      it "userが無ければ失敗する" do
        post = build(:post, user: nil)
        post.valid?
        expect(post.errors[:user]).to include('を入力してください')
      end

      it "bodyが50文字以内ではないと失敗する" do
        post = build(:post, body: "A" * 51)
        post.valid?
        expect(post.errors[:body]).to include('は50文字以内で入力してください')
      end

      it "topicが無ければ失敗する" do
        post = build(:post, topic: nil)
        post.valid?
        expect(post.errors[:topic]).to include('を入力してください')
      end
    end
  end

  describe ".select_topic_posts" do
    let(:topic_a) { create(:topic) }
    let(:topic_b) { create(:topic) }
    let(:post_a) { create(:post, topic: topic_a) }
    let(:post_b) { create(:post, topic: topic_b) }

    before do
      topic_a
      topic_b
    end

    context "指定したtopicのpostを抽出" do
      it "指定したtopicのpostが含まれているか" do
        expect(described_class.select_topic_posts(topic_a)).to include(post_a)
      end

      it "指定したtopicではないpostが含まれていないか" do
        expect(described_class.select_topic_posts(topic_a)).not_to include(post_b)
      end
    end
  end

  describe ".select_user_topic_posts" do
    let(:topic) { create(:topic) }
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:post_a) { create(:post, topic: topic, user: user_a) }
    let(:post_b) { create(:post, topic: topic, user: user_b) }

    before do
      topic
      user_a
      user_b
    end

    context "指定したtopicのpostを抽出" do
      it "指定したuserのpostが含まれているか" do
        expect(described_class.select_user_topic_posts(topic, user_a)).to include(post_a)
      end

      it "指定したuserではないpostが含まれていないか" do
        expect(described_class.select_user_topic_posts(topic, user_a)).not_to include(post_b)
      end
    end
  end
end
