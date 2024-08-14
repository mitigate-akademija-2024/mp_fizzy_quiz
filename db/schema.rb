# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_14_093409) do
  create_table "answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id", null: false
    t.string "text", null: false
    t.boolean "correct", default: false, null: false
    t.integer "score", default: 0
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quiz_id", null: false
    t.string "text", null: false
    t.integer "question_type", default: 0
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quiz_comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.integer "quiz_comment_id"
    t.string "text"
    t.index ["quiz_comment_id"], name: "index_quiz_comments_on_quiz_comment_id"
    t.index ["quiz_id"], name: "index_quiz_comments_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_comments_on_user_id"
  end

  create_table "quiz_shareds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quiz_id", null: false
    t.integer "user_id", null: false
    t.string "uuid", null: false
    t.integer "count"
    t.integer "share_type"
    t.index ["quiz_id"], name: "index_quiz_shareds_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_shareds_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "description"
    t.integer "quiz_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "published_type", default: 0, null: false
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "answer_id", null: false
    t.string "unique_answer"
    t.integer "user_score_id"
    t.index ["answer_id"], name: "index_user_answers_on_answer_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_scores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "correct_count", null: false
    t.integer "total_score"
    t.integer "quiz_id"
    t.index ["user_id"], name: "index_user_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quiz_comments", "quiz_comments"
  add_foreign_key "quiz_comments", "quizzes"
  add_foreign_key "quiz_comments", "users"
  add_foreign_key "quiz_shareds", "quizzes"
  add_foreign_key "quiz_shareds", "users"
  add_foreign_key "quizzes", "users"
  add_foreign_key "user_answers", "answers"
  add_foreign_key "user_answers", "user_scores"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_scores", "quizzes"
  add_foreign_key "user_scores", "users"
end
