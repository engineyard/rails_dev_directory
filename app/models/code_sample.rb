class CodeSample < ActiveRecord::Base
  include AASM
  
  belongs_to :provider
  
  attr_protected :score, :provider_id

  aasm_initial_state :review

  aasm_state :review
  aasm_state :show
  
  aasm_event :analyze do
    transitions :to => :show, :from => [:review]
  end
  
end
