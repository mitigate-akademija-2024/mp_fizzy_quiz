class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :quiz_type, default: 0

      t.timestamps
    end
  end
end
