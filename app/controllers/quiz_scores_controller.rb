class QuizScoresController < ApplicationController
    before_action :authenticate_user!
    before_action :set_quiz
    before_action :finished_quiz?, only: [:start, :submit]
    def start
        @questions = @quiz.questions
    end

    def show
        @user_score = @quiz.user_scores.where(user: current_user).last
        @questions = @quiz.questions
        @total_correct = 0
        
        @user_answers = []

        @questions.each do |question|
            clean_user_answers = []
            
            question.answers.each do |a|
                
                if current_user.user_answers.where(user_score: @user_score, answer: a).first
                    clean_user_answers.append(a)
                end
            end

            @user_answers.append(
                question: question,
                user_answers: clean_user_answers 
            )
        end

        @questions.each do |question|
            @total_correct += question.answers.count(correct: true)
        end
    end

    def submit
        @quiz = Quiz.find(params[:quiz_id])
        @user_score = UserScore.new(user: current_user, quiz: @quiz)

        answer_params.each do |question_id, answer_data|
            answer_data.each do |id, chosen|
                if chosen == "1"
                    @user_score.user_answers.build(
                        user: current_user,
                        answer_id: id,
                    )
                end
            end
        end
        
        answer_count = 0

        @user_score.user_answers.each do |answer|
            if answer.answer.correct
                answer_count += 1
            end
        end

        @user_score.correct_count = answer_count
        
        if @user_score.save
            redirect_to quiz_show_path, notice: "Quiz submitted successfully."
        else
            render :start, alert: "There was an error submitting your quiz!"
        end

    end
    
    protected

    def set_quiz
        @quiz = Quiz.find(params[:quiz_id])
    end

    def answer_params
        params.require(:answers)
    end

    def finished_quiz?
        if UserScore.where(user: current_user, quiz: params[:quiz_id]).first
            redirect_to quiz_show_path, alert: "You have allready completed the Quiz!"
        end
    end

end
