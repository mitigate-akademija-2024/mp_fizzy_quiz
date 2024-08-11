class QuizComment < ApplicationRecord
    belongs_to :quiz
    belongs_to :quiz_comment, optional: true
    belongs_to :user
    
    has_many :quiz_comments
end
