class My::QuizzesController < ApplicationController
  
  before_filter :require_user
  
  def index
    @quizzes = Quiz.all
  end
  
  def submit
    @quiz = Quiz.find(params[:id])
    questions_answered = []
    responses = []
    params[:answers] ||= {}
    params[:answers].each do |question, answer|
      questions_answered << @quiz.questions.find(question)
      current_user.provider.responses.find_all_by_question_id(question.id).each(&:destroy)
      responses << Response.new(
        :question_id => question,
        :provider => current_user.provider,
        :answer_id => answer
        )
    end
    if questions_answered.size == @quiz.questions.size
      responses.each(&:save)
      quiz = current_user.provider.quiz_results.find_or_create_by_quiz_id(@quiz.id)
      quiz.update_attributes(:score => @quiz.correct_responses_for(current_user.provider),
        :questions => @quiz.questions_per_quiz)
      current_user.provider.save
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
