class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.timestamps
      t.references :quiz, null: false, foreign_key: true
      t.string :text, null: false
      t.integer :question_type, default: 0
    end
  end
end
