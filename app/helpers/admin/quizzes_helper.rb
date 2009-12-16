module Admin::QuizzesHelper
  
  def setup_quiz(quiz)
    quiz.questions.build
    quiz.questions.each { |q| q.answers.build }
    quiz
  end
end
