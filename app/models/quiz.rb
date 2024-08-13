class Quiz < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :user

  has_many :questions, dependent: :destroy
  has_many :quiz_comments, dependent: :destroy
  has_many :user_scores, dependent: :destroy
  has_one :quiz_shared, dependent: :destroy

  def description_preview
    self.description.length > 30 ? "#{ self.description[0...27] }..." : self.description
  end

  def completed
    user_scores.count
  end

  def max_correct_answers
    user_scores.order(correct_count: :desc).first.correct_count
  end

  def max_score
    user_scores.order(total_score: :desc).first.total_score
  end

end
