begin
  require 'RedCloth'
rescue LoadError
  nil
end

require 'acts_as_textiled'
ActiveRecord::Base.send(:include, Err::Acts::Textiled)
