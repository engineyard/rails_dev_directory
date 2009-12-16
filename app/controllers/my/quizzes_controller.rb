class My::QuizzesController < ApplicationController
  
  before_filter :require_user
  
  def index
    @quizzes = Quiz.all
  end
  
  def take
    @quiz = Quiz.find(params[:id])
  end
  
  def submit
    @quiz = Quiz.find(params[:id])
    questions_answered = []
    responses = []
    params[:answers] ||= {}
    params[:answers].each do |question, answer|
      questions_answered << @quiz.questions.find(question)
      responses << Response.new(
        :question_id => question,
        :provider => current_user.provider,
        :answer_id => answer
        )
    end
    if questions_answered.size == @quiz.questions.size
      responses.each(&:save)
      current_user.provider.quiz_results.create!(
        :quiz => @quiz,
        :score => @quiz.correct_responses_for(current_user.provider))
      redirect_to(results_my_quiz_path(@quiz))
    else
      flash.now[:notice] = t('please_answer_all_questions')
      render :take
    end
  end
  
  def results
    @quiz = Quiz.find(params[:id])
  end
end
