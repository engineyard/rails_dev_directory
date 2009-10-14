module ShortcodeUrl
  def self.included(base) 
    base.extend ShortcodeUrlMethod
  end

  module ShortcodeUrlMethod
    def shortcode_url(options = {})
      length = options[:length] || 4

      before_create :set_shortcode_url
      before_update :set_shortcode_url

      class_eval do        
        
        define_method(:set_shortcode_url) do
          self.shortcode_url ||= create_shortcode_url
        end
        
        define_method(:create_shortcode_url) do
          begin
            unique_code = (("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ['-', '_']).sort_by{rand}[0,length].join
          end until( unique_code.to_i.zero? and not unique_code == '0000' and not self.class.find_by_shortcode_url(unique_code))
          return unique_code
        end
      end
    end
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, ShortcodeUrl)
end