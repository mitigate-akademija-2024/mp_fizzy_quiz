class Question < ApplicationRecord
    validates :text, presence: true
    
    belongs_to :quiz
    
    has_many :answers, dependent: :destroy
end
