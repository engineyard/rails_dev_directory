module AuditClassMethods
  def self.included(base) 
    base.extend AuditMethod
  end

  module AuditMethod
    def audit

      after_create :log_create_audit
      after_update :log_update_audit
      after_destroy :log_destroy_audit
      
      has_many(:audits, :as => :auditable) do
        def log_create!
          proxy_owner.audits.create!(:action => 'create', :user_id => current_user_id)
        end

        def log_update!
          proxy_owner.audits.create!(:action => 'update', :user_id => current_user_id)
        end
        
        def log_destroy!
          proxy_owner.audits.create!(:action => 'destroy', :user_id => current_user_id)
        end
      end
      
      def current_user_id
        User.current_user.id if User.respond_to?(:current_user)
      end
      
      def created
        Audit.created.by_object(self.to_s)
      end
      
      def updated
        Audit.updated.by_object(self.to_s)
      end
      
      def destroyed
        Audit.destroyed.by_object(self.to_s)
      end

      class_eval do        
        define_method(:log_create_audit) do
          audits.log_create!
        end
        
        define_method(:log_update_audit) do
          audits.log_update!
        end

        define_method(:log_destroy_audit) do
          audits.log_destroy!
        end
      end
    end
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, AuditClassMethods)
end