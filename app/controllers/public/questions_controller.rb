class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %w(new create edit update)
  before_action :ensure_correct_user, only: %w(edit update destroy)

  def index
    @questions = Question.search_by_category(params[:category], params[:page])
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