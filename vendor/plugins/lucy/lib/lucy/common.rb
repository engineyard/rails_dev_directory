module Lucy
  module Common

  def self.included(controller)
    controller.send(:before_filter, :generate_common_javascript)
  end

  private

    def generate_common_javascript
      unless Rails.env.production? && Thread.current[:common_javascript_generated]
        Lucy.generate "common" do |g|
          g.namespace = "Rails"
          g[:authenticityToken] = form_authenticity_token
          g[:env] = Rails.env
          g[:version] = Rails.version
        end
        Thread.current[:common_javascript_generated] = true
      end
    end

  end
end

ActionController::Base.send(:include, Lucy::Common)
