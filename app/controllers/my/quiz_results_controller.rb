class My::QuizResultsController < ApplicationController

  before_filter :require_user
  
  def new
    @quizzes = current_user.provider.uncompleted_quizzes.all(:order => 'name')
    @quiz_result = QuizResult.new
  end

  def create
    @quiz_result = QuizResult.new(params[:quiz_result])
    @quiz_result.provider = current_user.provider
    if @quiz_result.save
      redirect_to new_my_quiz_result_answer_path(:quiz_result_id => @quiz_result.id)
    else
      render :new
    end
  end

  def show
    @quiz_result = QuizResult.find(params[:id])
  end

end
