class Object
  # Metaid == a few simple metaclass helper
  # (See http://whytheluckystiff.net/articles/seeingMetaclassesClearly.html.)
  # The hidden singleton lurks behind everyone
  def metaclass() class << self; self end end
  def meta_eval(&blk) metaclass.instance_eval(&blk) end

  # Adds methods to a metaclass
  def meta_def(name, &blk)
    meta_eval { define_method(name, &blk) }
  end

  # Defines an instance method within a class
  def class_def(name, &blk)
    class_eval { define_method(name, &blk) }
  end
  
  ##
  # if ''.not.blank?
  # http://blog.jayfields.com/2007/08/ruby-adding-not-method-for-readability.html
  define_method :not do
    Not.new(self)
  end

  class Not
    private *instance_methods.select { |m| m !~ /(^__|^\W|^binding$)/ }

    def initialize(subject)
      @subject = subject
    end

    def method_missing(sym, *args, &blk)
      !@subject.send(sym,*args,&blk)
    end
  end

  def class_attr_accessor(*attrs)
    metaclass.send(:attr_accessor, *attrs)
  end
end
