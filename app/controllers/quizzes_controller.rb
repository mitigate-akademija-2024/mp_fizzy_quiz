class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :destroy, :update, :create, :new]

  # GET /quizzes or /quizzes.json
  def index
    if params[:user_id]
      @quizzes = Quiz.all.where(:user_id => params[:user_id])
    else
      @quizzes = Quiz.all
    end

  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully created." }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def leaderboard
    @quiz = Quiz.find(params[:quiz_id])
    @scores = @quiz.user_scores.order(correct_count: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data leaderboard_csv(@scores), filename: "quiz-#{Date.today}.csv"}
    end

  end

  def user_answers
    @user_answers = UserAnswer.where(user: current_user)
  end

  private

    def leaderboard_csv(scores)
      require 'csv'
      filtered = []
      scores.each do |score|
        filtered.append(
          username: score.user.username ? score.user.username : "Anonymous User",
          correct_count: score.correct_count,
          date: score.created_at.strftime('%F')
          )
      end
      attributes = %w{username correct_count date}
      CSV.generate(headers: true) do |csv|
        csv << attributes

        filtered.each do |score|
          csv << score.values
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:user_id, :title, :description, :type)
    end
end
