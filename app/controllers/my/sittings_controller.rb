class My::SittingsController < ApplicationController
  
  before_filter :require_user
  
  def new
    @sitting = Sitting.new(:provider => current_user.provider)
    @sitting.quiz = Quiz.find(params[:quiz_id])
    @sitting.save
    @quiz = @sitting.quiz
  end
  
  def update
    @sitting = current_user.provider.sittings.find(params[:id])
    @sitting.attributes = params[:sitting]

    if @sitting.expired?
      redirect_to [:my, @sitting]
      return
    end
    
    @sitting.quiz = Quiz.find(params[:quiz_id])
    @sitting.provider = current_user.provider
    @quiz = @sitting.quiz
    
    @sitting.responses.each do |response|
      response.provider = current_user.provider
    end

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
