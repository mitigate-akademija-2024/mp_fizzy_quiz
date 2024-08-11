class CreateUserAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :user_answers do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.string :unique_answer
    end
  end
end
