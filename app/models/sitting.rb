class Sitting < ActiveRecord::Base
  
  validate_on_create :previous_attempts_less_than_allowed
  
  has_many :responses
  belongs_to :quiz
  belongs_to :provider
  
  attr_protected :quiz_id, :provider_id
  
  accepts_nested_attributes_for :responses
  
  def score
    responses.correct.count
  end
  
  def expired?
    ((Time.now - created_at) / 60) > quiz.time_limit.to_i
  end
  
  def previous_attempts_less_than_allowed
    return unless provider
    if provider.sittings.count(:conditions => {:quiz_id => quiz_id}) >= quiz.attempts
      errors.add_to_base(I18n.t('cannot_take_quiz'))
    end
  end
end