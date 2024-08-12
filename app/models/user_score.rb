class UserScore < ApplicationRecord
    belongs_to :user
    belongs_to :quiz
    has_many :user_answers, dependent: :destroy
    accepts_nested_attributes_for :user_answers, allow_destroy: true
end
