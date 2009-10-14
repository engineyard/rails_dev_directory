module UrlField
  def self.included(base) 
    base.extend UrlFieldMethod
  end

  module UrlFieldMethod
    def url_field(field)

      before_save :clean_url_field

      class_eval do        
        
        define_method(:clean_url_field) do
          self.send("#{field}=", send("cleaned_#{field}"))
        end
        
        private
        
        define_method("cleaned_#{field}") do
          return nil if send(field).nil?
          return "http://#{send(field)}" unless send(field).match(/https?:\/\/.*$/)
          send(field)
        end
      end
    end
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, UrlField)
end