class My::SittingsController < ApplicationController
  
  def new
    @sitting = Sitting.new
    @sitting.quiz = Quiz.find(params[:quiz_id])
    @quiz = @sitting.quiz
  end
  
  def create
    @sitting = Sitting.new(params[:sitting])
    @sitting.quiz = Quiz.find(params[:quiz_id])
    @sitting.provider = current_user.provider
    @quiz = @sitting.quiz
    if @sitting.save
      quiz = current_user.provider.quiz_results.find_or_create_by_quiz_id(@quiz.id)
      quiz.update_attributes(
        :score => @sitting.score,
        :questions => @quiz.questions.size
      )
      redirect_to [:my, @sitting]
    else
      render :new
    end
  end
  
  def show
    @sitting = Sitting.find(params[:id])
    @quiz = @sitting.quiz
  end
end
