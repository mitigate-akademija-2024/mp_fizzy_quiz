class Quiz < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  belongs_to :user

  has_many :questions, dependent: :destroy
  has_many :quiz_comments, dependent: :destroy
  has_many :user_scores, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true

  enum quiz_type: { private_quiz: 0, public_quiz: 1 }
  enum published_type: { unpublished: 0, published: 1 }

  def description_preview
    max = 57
    self.description.length > max ? "#{ self.description[0...max] }..." : self.description
  end

  def completed
    user_scores.count
  end

  def max_correct_answers
    ordered = user_scores.order(correct_count: :desc).first
    if ordered
      user_scores.order(correct_count: :desc).first.correct_count
    end
  end

  def max_score
    ordered = user_scores.order(correct_count: :desc).first
    if ordered
      user_scores.order(total_score: :desc).first.total_score
    end
  end
end
