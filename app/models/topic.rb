class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :title, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
end
