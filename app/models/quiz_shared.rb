class QuizShared < ApplicationRecord
    validates :uuid, presence: true, uniqueness: true
    
    belongs_to :quiz
    belongs_to :user
end
