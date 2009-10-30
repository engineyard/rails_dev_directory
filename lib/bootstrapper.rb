require 'factory_girl'
require 'highline/import'
require 'spec/factories'
require 'spec/blueprints'
class Bootstrapper
  class << self
    def bootstrap!
      user.save!
      provider.save!

      provider.update_attribute(:user, user)
      user.update_attribute(:provider, provider)

      rfp.save!

      provider.rfps << rfp
      
      Factory.create(:page, :title => "Terms and Conditions", :url => "terms-of-use", :content => "Terms go here")
      Factory.create(:page, :title => "Provider Terms and conditions", :url => "provider-terms-of-use", :content => "Contact details here")
      Factory.create(:page, :title => "Provider signup", :url => 'provider-signup', :content => %Q[<ol class="wizard">
        <li class="step1">Fill out this form</li>
        <li class="step2">Create your portfolio</li>
        <li class="step3">Get 3 endorsements</li>
      </ol>])
      
      category = ServiceCategory.make(:name => "Programming", :proficiency => true)
      
      ruby = Service.make(:name => "Ruby on Rails", :checked => true, :category => category)
      Service.make(:name => "PHP", :checked => false, :category => category)
      
      Recommendation.make(:provider => provider, :aasm_state => 'approved')
      
      provider.services << ruby
    end
    
    def provider
      @provider ||= Factory.build(:provider)
    end
    
    def rfp
      @rfp ||= Factory.build(:rfp)
    end
    
    def user
      return @user if @user
      default_email = 'test@example.com'
      default_password = 'test'
      email = ask("Enter your email[#{default_email}]: ") { |q| q.echo = true }
      email = default_email if email.blank?
      password = ask("Enter your password[#{default_password}]: ") { |q| q.echo = "*" }
      password = default_password if password.blank?
      user = User.new(:email => email)
      user.password = password
      user.password_confirmation = password
      user.admin = true
      @user = user
    end
  end
end
