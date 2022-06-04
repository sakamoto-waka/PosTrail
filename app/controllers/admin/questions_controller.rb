class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin!, only: %w(edit update)

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      redirect_to admin_questions_path
    else
      render admin_question_edit_path(@question)
    end
  end

  def destroy
    @question.destroy
    @questions = Question.all
    redirect_to admin_questions_path
  end

  private
    def question_params
      params.require(:question).permit(:content,:title, :answer, :riding_experience, :category)
    end
end