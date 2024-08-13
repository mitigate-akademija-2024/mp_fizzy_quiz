class Question < ApplicationRecord
    validates :text, presence: true
    
    belongs_to :quiz
    
    has_many :answers, dependent: :destroy
    
    accepts_nested_attributes_for :answers, allow_destroy: true

    enum question_type: [ :multiple_choice, :single_choice, :open_question ]

end
