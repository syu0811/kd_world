class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :user_id, presence: true
  validates :body, length: { maximum: 50 }, presence: true
  validates :topic_id, presence: true

  scope :select_topic_posts, ->(topic) { where(topic: topic) }
  scope :select_user_topic_posts, ->(topic, user) { where(user: user, topic: topic) }
end
