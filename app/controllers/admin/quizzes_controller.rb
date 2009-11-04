class Admin::QuizzesController < ApplicationController

  before_filter :admin_required
  layout 'admin'

  def index
    @quizzes = Quiz.all
  end
  
  def new
    @quiz = Quiz.new
  end
  
  def create
    @quiz = Quiz.new(params[:quiz])
    if @quiz.save
      flash[:notice] = t('quiz.saved_successfully')
      redirect_to admin_quizzes_path
    else
      render :new
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end
  
  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(params[:quiz])
      flash[:notice] = t('quiz.saved_successfully')
      redirect_to admin_quizzes_path
    else
      render :edit
    end
  end
  
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    flash[:notice] = t('quiz.deleted_successfully')
    redirect_to admin_quizzes_path
  end

end
