class CreateQuizComments < ActiveRecord::Migration[7.2]
  def change
    create_table :quiz_comments do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      # Used when replying to a comment 
      t.references :quiz_comment, foreign_key: true
      t.string :text
    end
  end
end
