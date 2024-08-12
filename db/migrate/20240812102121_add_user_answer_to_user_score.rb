class AddUserAnswerToUserScore < ActiveRecord::Migration[7.2]
  def change
    add_column :user_answers, :user_score_id, :integer
    add_foreign_key :user_answers, :user_scores, column: :user_score_id, primary_key: :id
  end
end
