class Question < ApplicationRecord
    validates :text, presence: true
    validate :single_choice_answers_count
    validate :has_correct_answer
    belongs_to :quiz
    
    has_many :answers, dependent: :destroy
    
    accepts_nested_attributes_for :answers, allow_destroy: true

    enum question_type: { multiple_choice: 0, single_choice: 1 }

    def has_correct_answer
        answer_values = []
        self.answers.each do |answer|
            answer_values.append(answer.correct)
        end
        if !answer_values.include?(true)
            errors.add(:base, "At least one answer must be correct!")
        end
    end

    def single_choice_answers_count
        answer_values = []
        self.answers.each do |answer|
            if answer.correct
                answer_values.append(answer.correct)
            end
        end
        if (self.question_type == "single_choice") && (answer_values.count != 1)
            errors.add(:base, "Single Choice questions, can't have more than 1 correct answer!")
        end
    end

end
