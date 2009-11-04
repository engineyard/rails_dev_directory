module My::QuizResultsHelper
  def options_for_quiz_select(quizzes)
    quizzes.map { |quiz| [quiz.name, quiz.id] }
  end
end
