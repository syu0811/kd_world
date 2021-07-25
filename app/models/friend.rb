class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }
  validates :friend_id, presence: true
  validate :id_cannot_be_the_same_value

  def id_cannot_be_the_same_value
    error_msg = "同じユーザーがフレンドになることはできません。"
    errors.add(:user, error_msg) if user_id == friend_id
  end
end
