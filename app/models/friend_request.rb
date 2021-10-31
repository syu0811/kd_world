class FriendRequest < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'

  validates :user_id, presence: true, uniqueness: { scope: :applicant_id }
  validates :applicant_id, presence: true
  validate :id_cannot_be_the_same_value
  validate :already_registered_users

  def id_cannot_be_the_same_value
    error_msg = "自分に申請することはできません。"
    errors.add(:user, error_msg) if user_id == applicant_id
  end

  def already_registered_users
    error_msg = "すでに登録済みのユーザーに申請することはできません。"
    friend_list = Friend.get_friend_list_ids_array(applicant_id)
    errors.add(:user, error_msg) if friend_list.include?(user_id)
  end

  def self.get_user_list(id)
    friends = Friend.get_friend_list(id).pluck(:id).push(id)
    User.where.not(id: friends).order(Arel.sql('RANDOM()')).limit(10)
  end

  def self.get_request_user_list(id)
    FriendRequest.where(applicant_id: id)
  end

  def self.get_request_pending_user_list(id)
    FriendRequest.where(user_id: id)
  end
end
