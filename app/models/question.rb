class Question < ApplicationRecord
    validates :text, presence: true
    validate :has_correct_answer

    belongs_to :quiz
    
    has_many :answers, dependent: :destroy
    
    accepts_nested_attributes_for :answers, allow_destroy: true

    enum question_type: [ :multiple_choice, :single_choice, :true_false ]

    def has_correct_answer
        answer_values = []
        self.answers.each do |answer|
            answer_values.append(answer.correct)
        end
        if !answer_values.include?(true)
            errors.add(:base, "At least one answer must be correct!")
        end
    end
    
end
