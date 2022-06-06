class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %w(new create edit update)
  before_action :ensure_correct_user, only: %w(edit update destroy)

  def index
    if params[:category] == "beginner"
      @questions = Question.question_latest.where("category = ?", 0).page(params[:page])
    elsif params[:category] == "intermediate"
      @questions = Question.question_latest.where("category = ?", 1).page(params[:page])
    elsif params[:category] == "advanced"
      @questions = Question.question_latest.where("category = ?", 2).page(params[:page])
    else
      @questions = Question.question_latest.page(params[:page])
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path
      flash[:success] = "質問を送信しました　回答された場合に一覧に記載されます"
    else
      @questions = Question.all
      render :new
    end
  end

  private

    def ensure_correct_user
      @question = Question.find(params[:id])
      user = User.find(params[:user_id])
      unless (@question.user == user) || admin_signed_in?
        redirect_to new_user_session_path
      end
    end

    def question_params
      params.require(:question).permit(:content,:title, :riding_experience)
    end
end
