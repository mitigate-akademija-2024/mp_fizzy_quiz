class QuizScoresController < ApplicationController
    before_action :authenticate_user!
    before_action :finished_quiz?
    
    def start
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions
    end

    def submit
        @quiz = Quiz.find(params[:quiz_id])
        @user_score = UserScore.new(user: current_user, quiz: @quiz)

        answer_params.each do |question_id, answer_data|
            answer_data.each do |id, correct|
                @user_score.user_answers.build(
                    user: current_user,
                    answer_id: id,
                )
            end
        end

        @user_score.correct_count = @user_score.user_answers.where(correct: true).count   

        if @user_score.save
            redirect_to result, notice: "Quiz submitted successfully."
        else
            render :start, alert: "There was an error submitting your quiz!"
        end

    end
    
    protected

    def answer_params
        params.require(:answers)
    end

    def finished_quiz?
        if UserScore.where(user: current_user, quiz: params[:quiz_id]).first
            redirect_to root_path, alert: "You have allready completed the Quiz!"
        end
    end

end
