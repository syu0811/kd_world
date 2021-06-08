class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\Akd[0-9]{7}@st.kobedenshi.ac.jp\z/i.freeze

  belongs_to :department

  validates :name, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  validates :department_id, presence: true

  validates :reset_password_token, uniqueness: true
  validates :confirmation_token, uniqueness: true
  validates :unlock_token, uniqueness: true
end
