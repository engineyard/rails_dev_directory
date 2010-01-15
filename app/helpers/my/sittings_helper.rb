module My::SittingsHelper
  
  def setup_sitting(sitting)
    if sitting.responses.size < sitting.quiz.questions_per_quiz
      sitting.quiz.questions.all(:limit => sitting.quiz.questions_per_quiz, :order => "RAND()").each do |question|
        sitting.responses.build(:question => question) if sitting.responses.collect(&:question).not.include?(question)
      end
    end
    sitting
  end
end
