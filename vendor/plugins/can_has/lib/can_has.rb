require 'can_has/can_has'
require 'can_has/active_record'

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, CanHas)
  ActiveRecord::Base.send(:include, ActiveRecord::CanHas)
end