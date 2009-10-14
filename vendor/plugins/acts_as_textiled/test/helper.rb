$:.unshift File.dirname(__FILE__) + '/../lib'

begin
  require 'rubygems'
  require 'yaml'
  require 'mocha'
  require 'active_support'
  require 'test/spec'
  require 'RedCloth'
rescue LoadError
  puts "acts_as_textiled requires the mocha and test-spec gems to run its tests"
  exit
end

class ActiveRecord
  class Base
    attr_reader :attributes
    
    def initialize(attributes = {})
      @attributes = attributes.dup
      after_find if respond_to?(:after_find)
    end

    def method_missing(name, *args)
      if name.to_s[/=/]
        @attributes[key = name.to_s.sub('=','')] = value = args.first
        write_attribute key, value
      else
        self[name.to_s] 
      end
    end

    def save
      true
    end

    def reload
      self
    end

    def [](value)
      @attributes[value.to_s.sub('_before_type_cast', '')]
    end

    def self.global
      eval("$#{name.downcase}")
    end

    def self.find(id)
      item = global.detect { |key, hash| hash['id'] == id }.last
      new(item)
    end
  end
end unless defined? ActiveRecord

require File.dirname(__FILE__) + '/../init'

class Author < ActiveRecord::Base
  acts_as_textiled :blog => :lite_mode
end

class Story < ActiveRecord::Base
  acts_as_textiled :body, :description => :lite_mode

  def author
    @author ||= Author.find(author_id)
  end
end

class StoryWithAfterFind < Story 
  acts_as_textiled :body, :description => :lite_mode

  def after_find 
    textilize 
  end

  def self.name 
    Story.name 
  end

  def author
    @author ||= Author.find(author_id)
  end
end

$author = YAML.load_file(File.dirname(__FILE__) + '/fixtures/authors.yml')
$story  = YAML.load_file(File.dirname(__FILE__) + '/fixtures/stories.yml')
