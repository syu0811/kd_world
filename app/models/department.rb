class Department < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: { scope: :alphabet }
  validates :alphabet, presence: true, length: { is: 1 },
                       format: { with: /\A[A-Z]\z/ }
end
