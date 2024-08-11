json.extract! quiz, :id, :user_id, :title, :description, :quiz_type, :created_at, :updated_at
json.url quiz_url(quiz, format: :json)
