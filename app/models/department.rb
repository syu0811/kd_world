class Department < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :alphabet, presence: true, length: { maximum: 2 },
                       format: { with: /\A[A-Z]{1,2}\z/ }, uniqueness: true
end
