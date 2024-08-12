class AddUserscoresReferenceQuiz < ActiveRecord::Migration[7.2]
  def change
    add_column :user_scores, :quiz_id, :integer
    add_foreign_key :user_scores, :quizzes, column: :quiz_id, primary_key: :id
  end
end
