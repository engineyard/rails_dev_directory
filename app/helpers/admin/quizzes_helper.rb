module Admin::QuizzesHelper
  
  def setup_quiz(quiz)
    (quiz.total_questions.to_i - quiz.questions.count).times do
      quiz.questions.build
    end
    quiz.questions.each do |q|
      (quiz.options_per_question.to_i - q.answers.count).times do
        q.answers.build 
      end
    end
    quiz
  end
end
