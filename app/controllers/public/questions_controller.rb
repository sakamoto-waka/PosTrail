class Public::QuestionsController < ApplicationController
  before_action :authenticate_user! || :authenticate_admin!, only: %w(create edit update)
  before_action :ensure_correct_user, only: %w(edit update destroy)
  
  def index
    @questions = Question.all
    @question = Question.new
  end

  def create
    @question = current_user.questions(question_params)
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
    @qusetion = Question.find(params[:id])
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
      @qusetion = Question.find(params[:id])
      user = User.find(params[:user_id])
      unless (@question.user == user) || admin_signed_in?
        redirect_to new_user_session_path
        flash[:danger] = "ログインをすると質問できます"
      end
    end
    
    def question_params
      params.require(:question).permit(:content, :answer, :riding_experience)
    end
end
