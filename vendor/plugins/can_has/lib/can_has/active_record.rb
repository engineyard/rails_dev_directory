module ActiveRecord
  
  def self.included(base)
    super
  end
  module CanHas
    def method_missing(method_name, *args)
      check_user = args.first
      if method_name.to_s[0,7] == 'can_has' or method_name.to_s[0,8] == 'can_read'
        return true
      elsif method_name.to_s[0,4] == 'can_'
        return check_user == user if respond_to?(:user)
        return false
      end
      super(method_name, *args)
    end
  end
end
  