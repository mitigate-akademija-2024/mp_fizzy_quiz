class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :quizzes, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :user_scores, dependent: :destroy
  has_many :quiz_comments, dependent: :destroy
end
