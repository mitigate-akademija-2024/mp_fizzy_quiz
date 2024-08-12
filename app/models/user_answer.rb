class UserAnswer < ApplicationRecord 
    belongs_to :user
    belongs_to :answer
    belongs_to :user_score
end
