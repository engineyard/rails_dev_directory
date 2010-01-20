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
      
      create_categories_and_services
      
      Endorsement.make(:provider => provider, :aasm_state => 'approved')
      
      q = Quiz.make({"options_per_question"=>5, "name"=>"Rails Quiz", "skill_level"=>"beginner", "total_questions"=>5, "time_limit"=>5, "questions_per_quiz"=>5})

      qu = Question.make({"text"=>"Who Made Rails?"})
      q.questions << qu
      qu.answers << Answer.make(:text => "DHH")
      qu.update_attributes(:correct_answer => qu.answers.first)
      qu.answers << Answer.make(:text => "PC")
      qu.answers << Answer.make(:text => "NF")
      qu.answers << Answer.make(:text => "BDJ")
      qu.answers << Answer.make(:text => "JD")
      
      qu = Question.make({"text"=>"What's Rails Written In?"})
      q.questions << qu
      qu.answers << Answer.make(:text => "Ruby")
      qu.update_attributes(:correct_answer => qu.answers.first)
      qu.answers << Answer.make(:text => "Perl")
      qu.answers << Answer.make(:text => "PHP")
      qu.answers << Answer.make(:text => "Python")
      qu.answers << Answer.make(:text => "Java")
      
      qu = Question.make({"text"=>"How do you get the number of items in an array?"})
      q.questions << qu
      qu.answers << Answer.make(:text => "Array#size")
      qu.update_attributes(:correct_answer => qu.answers.first)
      qu.answers << Answer.make(:text => "Array#pick")
      qu.answers << Answer.make(:text => "Array#fill")
      qu.answers << Answer.make(:text => "Array#inspect")
      qu.answers << Answer.make(:text => "Array#items")
      
      qu = Question.make({"text"=>"What's quirky about the Rails logo?"})
      q.questions << qu
      qu.answers << Answer.make(:text => "It's trademarked")
      qu.update_attributes(:correct_answer => qu.answers.first)
      qu.answers << Answer.make(:text => "It's red")
      qu.answers << Answer.make(:text => "It's blue")
      qu.answers << Answer.make(:text => "It's a ruby on rails")
      qu.answers << Answer.make(:text => "It's lovely")
      
      qu = Question.make({"text"=>"When was Rails released?"})
      q.questions << qu
      qu.answers << Answer.make(:text => "2004")
      qu.update_attributes(:correct_answer => qu.answers.first)
      qu.answers << Answer.make(:text => "1970")
      qu.answers << Answer.make(:text => "1980")
      qu.answers << Answer.make(:text => "1990")
      qu.answers << Answer.make(:text => "2000")
      
      provider.services << Service.find_by_name('Ruby')
    end
    
    def provider
      @provider ||= Factory.build(:provider)
    end
    
    def rfp
      @rfp ||= Factory.build(:rfp)
    end
    
    def create_categories_and_services
      
      puts "Creating Categories and Services"
      puts "Languages"
      languages = ServiceCategory.make(:name => "Spoken Language", :position => 1, :proficiency => true)
      languages.services << Service.make(:name => "English", :position => 1, :priority => 1)
      languages.services << Service.make(:name => "French", :position => 2, :priority => 1)
      languages.services << Service.make(:name => "Italian", :position => 3, :priority => 1)
      languages.services << Service.make(:name => "Spanish", :position => 4, :priority => 1)

      puts "General"
      general = ServiceCategory.make(:name => "General", :position => 2)
      general.services << Service.make(:name => "AJAX / Javascript Coding", :position => 1, :priority => 2)
      
      puts "Programming"
      programming = ServiceCategory.make(:name => "Programming Languages", :position => 3, :proficiency => true)
      programming.services << Service.make(:name => "C++", :position => 1, :priority => 2)
      programming.services << Service.make(:name => "PHP", :position => 2, :priority => 2)
      programming.services << Service.make(:name => "Ruby", :position => 3, :priority => 2)
      programming.services << Service.make(:name => "Java", :position => 4, :priority => 2)
      
      puts "Stack"
      stack = ServiceCategory.make(:name => "Rails Stack", :position => 4, :proficiency => true)
      stack.services << Service.make(:name => "Phusion Passenger", :position => 1, :priority => 2)
      stack.services << Service.make(:name => "nginx", :position => 2, :priority => 2)
      stack.services << Service.make(:name => "unicorn", :position => 3, :priority => 2)
      stack.services << Service.make(:name => "Mongrel", :position => 4, :priority => 2)
      
      puts "Toolkit"
      toolkit = ServiceCategory.make(:name => "Toolkit", :position => 5, :proficiency => true)
      toolkit.services << Service.make(:name => "Cucumber", :position => 1, :priority => 2)
      toolkit.services << Service.make(:name => "RSpec", :position => 2, :priority => 2)
      toolkit.services << Service.make(:name => "Ruby on Rails", :position => 3, :priority => 2)

      puts "Methodologies"
      methodologies = ServiceCategory.make(:name => "Methodologies", :position => 6, :proficiency => true)
      methodologies.services << Service.make(:name => "Behavior Driven Development", :position => 1, :priority => 2)
      
      puts "Payment Methods"
      payment_methods = ServiceCategory.make(:name => "Accepted Payment Methods", :position => 1, :proficiency => false)
      payment_methods.services << Service.make(:name => "Paypal", :position => 1, :priority => 3)
      payment_methods.services << Service.make(:name => "Credit Card", :position => 2, :priority => 3)
      payment_methods.services << Service.make(:name => "Bank Transfer", :position => 3, :priority => 3)
      
    end
    
    def user
      return @user if @user
      default_email = 'test@example.com'
      default_password = 'test'
      email = ask("Enter your email[#{default_email}]: ") { |q| q.echo = true }
      email = default_email if email.blank?
      password = ask("Enter your password[#{default_password}]: ") { |q| q.echo = "*" }
      password = default_password if password.blank?
      user = User.make_unsaved(:email => email)
      user.password = password
      user.password_confirmation = password
      user.admin = true
      @user = user
    end
  end
end
