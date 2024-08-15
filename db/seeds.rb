# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


users = [
    {
        :email => "funky@email.test",
        :username => "Funky Mc Funker",
        :password => "TopSecret",
        :password_confirmation => "TopSecret",
        :quizzes_attributes => [
            {
                :title => "This is my First Quiz!",
                :description => "I finally made a quiz! How cool is that :D",
                :quiz_type => 1,
                :published_type => 1
            },
            {
                :title => "The Funky Music Quiz",
                :description => "Test your knowledge of funky music!",
                :quiz_type => 1,
                :published_type => 1
            }
        ]
    },
    {
        :email => "coolcat@email.test",
        :username => "Cool Cat",
        :password => "MeowMeow123",
        :password_confirmation => "MeowMeow123",
        :quizzes_attributes => [
            {
                :title => "Purr-fect Quiz!",
                :description => "How much do you know about cats?",
                :quiz_type => 1,
                :published_type => 1
            }
        ]
    },
    {
        :email => "techguy@email.test",
        :username => "Tech Guy",
        :password => "SecurePass2024",
        :password_confirmation => "SecurePass2024",
        :quizzes_attributes => [
            {
                :title => "Tech Trivia",
                :description => "Are you a true tech geek? Let's find out!",
                :quiz_type => 1,
                :published_type => 1
            },
            {
                :title => "Programming Languages",
                :description => "Can you identify these programming languages?",
                :quiz_type => 1,
                :published_type => 1
            }
        ]
    },
    {
        :email => "adventuretime@email.test",
        :username => "Adventure Time",
        :password => "Adventure123",
        :password_confirmation => "Adventure123",
        :quizzes_attributes => [
            {
                :title => "The Ultimate Adventure Quiz",
                :description => "Test your adventure knowledge!",
                :quiz_type => 1,
                :published_type => 1
            }
        ]
    },
    {
        :email => "booklover@email.test",
        :username => "Book Lover",
        :password => "ReadingIsFun",
        :password_confirmation => "ReadingIsFun",
        :quizzes_attributes => [
            {
                :title => "Literature Quiz",
                :description => "How well do you know classic literature?",
                :quiz_type => 1,
                :published_type => 1

            },
            {
                :title => "Modern Books",
                :description => "Identify these popular modern books!",
                :quiz_type => 1,
                :published_type => 1
            }
        ]
    }
]

questions = [
    {
        :text => "This is a test question?",
        :question_type => 0,
        :answers_attributes => [
            {
                :text => "Test Answer1",
                :correct => true
            },
            {
                :text => "Test Answer2",
                :correct => false
            },
            {
                :text => "Test Answer3",
                :correct => true
            }
        ]
    },
    {
        :text => "This is a test question but this time only one correct answer?",
        :question_type => 1,
        :answers_attributes => [
            {
                :text => "Test Answer1",
                :correct => true
            },
            {
                :text => "Test Answer2",
                :correct => false
            },
            {
                :text => "WOOOW",
                :correct => false
            }
        ]
    }
]

users.each do |user|
    @user = User.new(user)
    @user.quizzes.each do |quiz|
        quiz.questions.new(questions)
        quiz.questions.save
    end
    
    @user.save
end
