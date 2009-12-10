require 'active_support'
module Behavior
  def self.included(base)
    base.class_eval do
      def config
        Behavior::Configuration.new
      end      
      helper_method :config if respond_to?(:helper_method)
    end
  end
  
  class Configuration
    def meta
      HashWithIndifferentAccess.new(YAML.load_file(Behavior::Settings.config_file))
    end
    
    def [](key)
      begin
        BehaviorConfig.find_by_key(key.to_s).value
      rescue NoMethodError
        meta[key][:default]
      end
    end
    
    def all
      meta.keys
    end
    
    def update(attrs = {})
      attrs.each do |key,value|
        result = BehaviorConfig.find_by_key(key.to_s)
        result.update_attribute(:value, value) if result
      end
    end
  end
  
  class Settings
    class << self
      def config_file
        @config_file ||= "#{Rails.root}/config/behavior.yml"
      end
      
      def config_file=(file)
        @config_file = file
      end
      
      def layout
        @layout ||= 'admin'
      end
      
      def layout=(layout_choice)
        @layout = layout_choice
      end
      
      def before_filters
        @before_filters ||= []
      end
      
      def before_filters=(filters)
        @before_filters = filters
      end
    end
  end
  
end

ActionController::Base.send(:include, Behavior)