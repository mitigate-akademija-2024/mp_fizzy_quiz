class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [ :create, :new ]
  before_action :authenticate_author!, only: [ :edit, :destroy, :update ]
  before_action :user_scores_exist?, only: [ :edit, :update ]

  # GET /quizzes or /quizzes.json
  def index
    puts "Index"
    if params[:user_id]
      @quizzes = Quiz.all.where(:user_id => params[:user_id])
    else
      @quizzes = Quiz.all.where(quiz_type: :public_quiz, published_type: :published)
      puts @quizzes
    end

  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    @question = @quiz.questions.new
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
    if params[:quiz_id].present?
      @quiz = Quiz.find(params[:quiz_id])
      @scores = @quiz.user_scores.order(correct_count: :desc)
    end
  

    respond_to do |format|
      format.html
      format.csv { send_data leaderboard_csv( @scores ), filename: "quiz-#{@quiz.id}-#{Date.today}.csv" }
    end

  end

  def global_leaderboard
    @ordered = UserScore.group(:user_id).select('SUM(correct_count) as total_score, user_id').order('total_score desc')

    respond_to do |format|
      format.html
      format.csv { send_data gleaderboar_csv(@ordered), filename: "global-#{Date.today}.csv" }
    end
  end

  private

    def authenticate_author!
      if current_user != @quiz.user
        redirect_to quizzes_url, alert: "You do not have permissions to edit this quiz!"
      end
    end

    def user_scores_exist?
      if @quiz.user_scores.all.first
        redirect_to quiz_url, alert: "Quiz has allready been completed!"
      end
    end

    def gleaderboar_csv(ordered)
      @user_scores_filtered = []      

      ordered.each do |user|  
        username = User.find(user.user_id).username
        username = username ? username : "Anon"
        @user_scores_filtered.append(
          user: username,
          total_correct: user.total_score,
          total_quizzes: User.find(user.user_id).user_scores.count
        )
      end

      require 'csv'
      attributes = %w{username total_correct total_quizzes}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        @user_scores_filtered.each do |score|
          csv << score.values
        end
      end
    end

    def leaderboard_csv(scores)
      require 'csv'
      filtered = []
      scores.each do |score|
        filtered.append(
          username: score.user.username ? score.user.username : "Anonymous User",
          correct_count: score.correct_count,
          date: score.created_at
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
      params.require(:quiz).permit(:user_id, :title, :description, :quiz_type, :published_type, questions_attributes: [ :id, :text, :question_type, answers_attributes: [ :text, :correct, :id] ])
    end
end
