class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin!, only: %w(edit update)

  def index
    if params[:is_answered] == 'true'
      @questions = Question.question_latest.where(is_answered: true)
    elsif params[:is_answered] == 'false'
      @questions = Question.question_latest.where(is_answered: false)
    else
      @questions = Question.question_latest
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to admin_questions_path
      flash[:success] = "質問を更新しました"
    else
      render template: "admin/questions/edit"
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    @questions = Question.all
    redirect_to admin_questions_path
    flash[:danger] = "質問を削除しました"
  end

  private
    def question_params
      params.require(:question).permit(:content,:title, :answer, :riding_experience, :category, :is_answered)
    end
end
