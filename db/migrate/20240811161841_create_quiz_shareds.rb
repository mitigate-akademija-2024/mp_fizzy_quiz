class CreateQuizShareds < ActiveRecord::Migration[7.2]
  def change
    create_table :quiz_shareds do |t|
      t.timestamps
      t.references :quiz, null: false, foreign_key: true
      t.string :uuid, null: false
      t.integer :count
      t.integer :share_type
    end
  end
end
