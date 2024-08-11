class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.timestamps
      t.references :question, null: false, foreign_key: true
      t.string :text, null: false
      t.boolean :correct, null: false, default: false
      t.integer :score, default: 0
    end
  end
end
