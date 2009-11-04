class My::QuizResultAnswersController < ApplicationController

  before_filter :require_user

  def new
    @quiz_result = QuizResult.find(params[:quiz_result_id])
    @quiz_result_answer = @quiz_result.unanswered.first
  end

  def update
    @quiz_result_answer = QuizResultAnswer.find(params[:id])
    @quiz_result = @quiz_result_answer.quiz_result

    if @quiz_result.completed?
      flash[:error] = t('quiz_result.already_completed')
      redirect_to my_quiz_result_path(@quiz_result)
    end

    if @quiz_result_answer.update_attributes(params[:quiz_result_answer])
      @quiz_result_answer.update_attribute(:correct, @quiz_result_answer.answer.correct)
      if @quiz_result.unanswered.any?
        redirect_to new_my_quiz_result_answer_path(:quiz_result_id => @quiz_result.id)
      else
        @quiz_result.mark!
        redirect_to my_quiz_result_path(@quiz_result)
      end
    else
      render :new
    end
  end

end
