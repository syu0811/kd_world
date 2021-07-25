class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\Akd[0-9]{7}@st.kobedenshi.ac.jp\z/i.freeze

  belongs_to :department
  has_many :topics
  has_many :posts
  has_many :user_friends, class_name: 'Friends', foreign_key: 'user_id'
  has_many :friend_friends, class_name: 'Friends', foreign_key: 'friend_id'
  has_many :user_friend_requests, class_name: 'FriendRequests', foreign_key: 'user_id'
  has_many :applicant_friend_requests, class_name: 'FriendRequests', foreign_key: 'applicant_id'

  validates :name, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :department_id, presence: true
end
