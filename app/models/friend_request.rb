class FriendRequest < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'

  validates :user_id, presence: true, uniqueness: { scope: :applicant_id }
  validates :applicant_id, presence: true
  validate :id_cannot_be_the_same_value

  def id_cannot_be_the_same_value
    error_msg = "自分に申請することはできません。"
    errors.add(:user, error_msg) if user_id == applicant_id
  end
end
