class CreateUserScores < ActiveRecord::Migration[7.2]
  def change
    create_table :user_scores do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.integer :correct_count, null: false
      t.integer :total_score
    end
  end
end
