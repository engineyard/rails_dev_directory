class QuizResult < ActiveRecord::Base

  validates_uniqueness_of :provider_id, :scope => :quiz_id

  belongs_to :provider
  belongs_to :quiz
  
  after_save :activate_provider_if_full_marks
  
  named_scope :passed, :conditions => ['score = questions']
  
  def activate_provider_if_full_marks
    if provider.aasm_state == 'inactive'
      provider.activate! if quiz and provider and score == quiz.questions.size
    end
  end

end
