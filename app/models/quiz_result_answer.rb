class QuizResultAnswer < ActiveRecord::Base

  belongs_to :quiz_result
  belongs_to :question
  belongs_to :answer

  validates_presence_of :answer_id, :on => :update,
                        :message => I18n.t('quiz_result_answer.no_answer')

  attr_protected :correct

end
