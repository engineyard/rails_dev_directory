class My::QuizzesController < ApplicationController
  
  def index
    @quizzes = Quiz.all
  end
  
  def take
    @quiz = Quiz.find(params[:id])
  end
end
