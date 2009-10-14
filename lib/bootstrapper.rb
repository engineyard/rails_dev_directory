require 'factory_girl'
require 'highline/import'
require 'spec/factories'
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
      
      Factory.create(:technology_type)
      Factory.create(:technology_type, :name => "Visual Design", :checked => false)
      
    end
    
    def provider
      @provider ||= Factory.build(:provider)
    end
    
    def rfp
      @rfp ||= Factory.build(:rfp)
    end
    
    def user
      return @user if @user
      email = ask("Enter your email:  ") { |q| q.echo = true }
      password = ask("Enter your password:  ") { |q| q.echo = "*" }
      user = User.new(:email => email)
      user.password = password
      user.password_confirmation = password
      user.admin = true
      @user = user
    end
  end
end
