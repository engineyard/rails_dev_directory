require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Provider do
  before(:all) do
    Provider.destroy_all
  end
  
  before(:each) do
    @valid_attributes = {
      :company_name => "Hyper Tiny",
      :city => "Dublin",
      :state_province => "NA",
      :email => 'paul@rslw.com',
      :company_url => 'http://www.rslw.com'
    }
  end

  it "should create a new instance given valid attributes" do
    Provider.new(@valid_attributes).should be_valid
  end
  
  it "should generate options for company size" do
    Provider.options_for_company_size.should == [
      ["2-10", 2], ["11-30", 11], ["31-100", 31], ["100+", 100]
]
  end
  
  describe "counter cache on recommendations" do
    it "should increment the recommendations on the provider counter cache" do
      provider = Factory.create(:test_provider, :company_name => "Counter Slug")
      provider.recommendations << Factory.create(:test_recommendation, :aasm_state => 'approved')
      provider.reload
      provider.recommendations_count.should == 1
    end
  end
  
  describe "searching" do
    it "should search on budget" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and min_budget <= ?", 20000], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:budget => "20000"})
    end
    
    it "should search on budget with weird formatting" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and min_budget <= ?", 20000], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:budget => "20,000"})
    end
    
    it "should search on services provided" do
      Provider.should_receive(:all).with(:joins => :provided_services, :group => 'provider_id', :conditions => ["aasm_state != 'flagged' and provided_services.service_id IN (?)", [1,2,3]], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:service_ids => [1,2,3]})
    end
    
    it "should search on country" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and country = ?", 'IE'], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:location => 'IE'})
    end
    
    it "should search on state" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and state_province = ?", 'FL'], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:location => 'US-FL'})
    end
    
    it "should search on many countries" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and country IN (?)", ['IE', 'US']], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:countries => ['IE', 'US']})
    end
    
    it "should search on many states" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and state_province IN (?)", ['FL', 'NY']], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:states => ['FL', 'NY']})
    end
    
    it "should search on many states and many countries" do
      Provider.should_receive(:all).with(:joins => nil, :group => nil, :conditions => ["aasm_state != 'flagged' and country IN (?) and if(country = 'US', state_province IN (?), ?)", ['IE', 'US'], ['FL', 'NY'], true], :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
      Provider.search({:countries => ['IE', 'US'], :states => ['FL', 'NY']})
    end
  end
    
  describe "default tech types" do
    before do
      @tech_type = Service.create!(:name => "Default", :checked => true)
      @provider = Provider.create!(@valid_attributes)
    end
    
    it "should have Default as tech type" do
      @provider.services.include?(@tech_type).should be_true
    end
    
    after do
      Service.destroy_all
    end
  end

  describe "combining the address" do
    before do
      @provider = Provider.new(:street_address => 'Billy', :city => 'Jean', :state_province => "NA", :postal_code => 10050, :country => nil)
    end
    
    it "should give me the address back" do
      @provider.address.should == ['Billy', 'Jean', 10050]
    end
    
    it "should give me a private address, without the street name" do
      @provider.private_address.should == ['Jean']
    end
  end
  
  describe "state machine methods" do
    
    before do
      @provider = Provider.create!(@valid_attributes)
    end
    
    it "should have all the states available for a select" do
      Provider.states.should == ['active', 'flagged', 'inactive']
    end

    it "should assign a default aasm state as inactive" do
      @provider.aasm_state.should == 'inactive'
    end
    
    it "should assign the aasm state to a status method" do
      @provider.status.should == 'inactive'
    end
  end
  
  describe "with a user" do
    before do
      @provider = Provider.new(@valid_attributes.merge(:users_attributes => {'0' => {:password => 'password', :password_confirmation => 'password', :email => 'dongle@rslw.com'}}))    
      @provider.users.first.password = 'password'
      @provider.users.first.password_confirmation = 'password'
    end
    
    it "should be valid" do
      @provider.should be_valid
    end
    
    it "should assign the first user as the administrator" do
      @provider.save!
      @provider.user.should == @provider.users.first
    end
  end
  
  describe "creating a slug" do
    before do
      @provider = Provider.new(@valid_attributes.merge({:company_name => "The big Friendly Six's Are parting", :city => "Test"}))
    end
    
    it "should reformat the slug" do
      @provider.slugged_company_name.should == 'the-big-friendly-sixs-are-parting'
    end
    
    it "should save the slug" do
      @provider.save!
      @provider.slug.should == @provider.slugged_company_name
    end
  end

  describe "making sure that the email and url domain match" do
    before do
      @provider = Provider.new(@valid_attributes.merge(:email => 'paul@rslw.com', :company_url => 'http://www.hypertiny.net', :users_attributes => {'0' => {:email => 'paul@rslw.com', :password => 'password', :password_confirmation => 'password'}}))
      @provider.users.first.password = 'password'
      @provider.users.first.password_confirmation = 'password'
    end
    
    it "should be invalid on the user email" do
      @provider.valid?
      @provider.should have(1).errors
    end
    
  end
  
  describe "formatting prices" do
    before do
      @provider = Provider.new(:hourly_rate => 150, :min_budget => 1500 )
    end
    
    it "should format the prices" do
      @provider.hourly_rate_formatted.should == "150.00"
      @provider.min_budget_formatted.should == "1500.00"
    end
  
    describe "when price is 0 or nul" do
      before do
        @provider = Provider.new
      end
      
      it "should render the prices as nul" do
        @provider.hourly_rate_formatted.should be_nil
        @provider.min_budget_formatted.should == "0.00"
      end
    end
  end
end

describe Provider, "accepting a long marketing description" do
  it "should not be invalid" do
    Provider.new(:marketing_description => "Seven Scale turns back-of-the-napkin ideas into groundbreaking,\r\nrevenue-generating products.\r\n\r\nWe live and breathe Web services and API-driven cloud services. Seven\r\nScale created Cloudvox (cloudvox.com), Clover (cloverapp.com), and\r\nRuby bindings for Tokyo Dystopia (Tokyo Cabinet). @sevenscale and thi").should have(0).errors_on(:marketing_description)
  end
end

describe Provider, "trying to register a reserved country / state name" do
  before do
    @provider = Factory.build(:test_provider)
  end
  
  it "should not allow me to register a country name" do
    @provider.company_name = "Ireland"
    @provider.valid?
    @provider.should have(1).errors_on(:company_name)
  end
  
  it "should not allow me to register a state name" do
    @provider.company_name = "Florida"
    @provider.valid?
    @provider.should have(1).errors_on(:company_name)
  end
end

describe Provider, "receiving email on signup" do
  it "should send the provider welcome" do
    @provider = Provider.new({"city"=>"Dublin", "state_province"=>"", "further_street_address"=>"28 Malahide Road", "company_url"=>"rushedsunlight.com", "country"=>"IE", "company_name"=>"Rushed Sunlight", "company_size"=>"2", "postal_code"=>"Dublin 3", "hourly_rate"=>"", "marketing_description"=>"", "phone_number"=>"[FILTERED]", "street_address"=>"28 Malahide Road", "terms_of_service"=>"1", "users_attributes"=>{"0"=>{"password_confirmation"=>"[FILTERED]", "last_name"=>"CAmpbell", "password"=>"[FILTERED]", "email"=>"paul@rushedsunlight.com", "first_name"=>"Paul"}}, "min_budget"=>"0.0", "email"=>"paul@rushedsunlight.com"})
    @provider.users.first.password = 'monkeys'
    @provider.users.first.password_confirmation = 'monkeys'
    
    @provider.should be_valid
    
    Notification.should_not_receive(:create_user_welcome)
    Notification.should_receive(:create_provider_welcome)
    
    @provider.save
  end
end