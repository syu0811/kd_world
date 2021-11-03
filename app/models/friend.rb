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

  scope :get_friend_list, ->(id) { User.where(id: get_friend_list_ids_array(id)) }
  scope :get_friend_table_id, ->(user_id, friend_id) { where(user_id: user_id, friend_id: friend_id).or(where(user_id: friend_id, friend_id: user_id)) }

  def self.get_friend_list_ids_array(id)
    friend_list = Friend.select(:friend_id).where(user_id: id).group(:friend_id).pluck(:friend_id) + Friend.select(:user_id).where(friend_id: id).group(:user_id).pluck(:user_id).sort!
    friend_list.sort!
  end
end
