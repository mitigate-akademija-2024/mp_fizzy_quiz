class AddPublishedTypeToQuiz < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :published_type, :integer, default: 0, null: false
  end
end
