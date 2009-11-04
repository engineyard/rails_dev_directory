module Admin::QuestionsHelper

  def setup_question(question)
    (Question::ANSWERS - question.answers.size).times do
      question.answers.build
    end
  end

end
