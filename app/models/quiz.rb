class Quiz < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :user

  has_many :questions, dependent: :destroy
  has_many :quiz_comments, dependent: :destroy
  has_one :quiz_shared, dependent: :destroy
end
