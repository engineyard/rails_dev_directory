module My::SittingsHelper
  
  def setup_sitting(sitting)
    if sitting.responses.size < sitting.quiz.questions_per_quiz
      sitting.quiz.questions.all(:limit => sitting.quiz.questions_per_quiz).each do |question|
        sitting.responses.build(:question => question)
      end
    end
    sitting
  end
end
