class QuestionsController < ApplicationController
    before_action :set_quiz, only: [:new, :create]
    before_action :set_question, only: [:destroy, :edit, :update]
    before_action :authenticate_user!
    def index
    end

    def create
        @question = @quiz.questions.new(question_params)

        if @question.save
            flash.notice  = "Question created Success!"
            redirect_to quiz_url(@quiz)
        else
            render :new, status: :unprocessable_entity
        end
    end
        
    def start
    end

    def new
        @question = @quiz.questions.new
    end

    def edit
    end

    def update
        respond_to do |format|
            if @question.update(question_params)
              format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
              format.json { render :show, status: :ok, location: @question }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @question.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @question.destroy!
        redirect_to quiz_path(@question.quiz), notice: "Question was deleted succsessfully!"
    end

    def answer_fields
      @question_type = params[:type]
      render partial: "answers/#{@question_type}", locals: { form: form_builder_instance }
    end

    protected

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
  
    def set_question
      @question = Question.find(params[:id])
    end
  
    def question_params
      params.require(:question).permit(:text, answers_attributes: [:id, :text, :correct, :_destroy])
    end

end
