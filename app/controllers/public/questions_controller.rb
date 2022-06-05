class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %w(new create edit update)
  before_action :ensure_correct_user, only: %w(edit update destroy)

  def index
    if params[:category] == "0"
      @questions = Question.where("category = ?", 0)
    elsif params[:category] == "1"
      @questions = Question.where("category = ?", 1)
    elsif params[:category] == "2"
      @questions = Question.where("category = ?", 2)
    else
      @questions = Question.all
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path
      flash[:success] = "質問を送信しました"
    else
      @questions = Question.all
      render :new
      flash[:danger] = "質問が送信できませんでした"
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to request.referer
    else
      render question_edit_path(@question)
    end
  end

  def destroy
    @question.destroy
    @questions = Question.all
    redirect_to questions_path
  end

  private

    def ensure_correct_user
      @question = Question.find(params[:id])
      user = User.find(params[:user_id])
      unless (@question.user == user) || admin_signed_in?
        redirect_to new_user_session_path
        flash[:danger] = "ログインをすると質問できます"
      end
    end

    def question_params
      params.require(:question).permit(:content,:title, :riding_experience)
    end
end
