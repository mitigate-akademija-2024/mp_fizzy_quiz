class QuizCommentsController < ApplicationController
    before_action :set_quiz
    before_action :authenticate_user!

    def create
        @quiz_comment = @quiz.quiz_comments.new(quiz_comment_params)
        @quiz_comment.user = current_user  # Assuming you have a `current_user` method
    
        if @quiz_comment.save
            redirect_to @quiz, notice: 'Comment was successfully created.'
        else
            redirect_to @quiz, alert: 'Comment could not be created.'
        end
    end
  
    private
  
    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
  
    def quiz_comment_params
      params.require(:quiz_comment).permit(:text, :quiz_comment_id)
    end
end
