# CanHas
module CanHas
  def self.included(base) 
    base.extend CanHasMethods
  end

  module CanHasMethods
    def can_has?
      class_eval do
        define_method "method_missing" do |method_name, *args|
          if method_name.to_s[0,4] == 'can_'
            object = args.first
            return object.send(method_name, self)
          end
          super(method_name, *args)
        end
      end
    end
  end
end