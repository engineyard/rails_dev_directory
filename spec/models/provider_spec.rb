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
    
  describe "counter cache on endorsements" do
    it "should increment the endorsements on the provider counter cache" do
      provider = Factory.create(:test_provider, :company_name => "Counter Slug")
      provider.endorsements << Endorsement.make(:aasm_state => 'approved')
      provider.reload
      provider.endorsements_count.should == 1
    end
  end
  
  describe "searching" do
    it "should search on budget" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and min_budget <= ?", 20000], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:budget => "20000"})
    end
    
    it "should search on budget with weird formatting" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and min_budget <= ?", 20000], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:budget => "20,000"})
    end
    
    it "should search on services provided" do
      Provider.should_receive(:paginate).with(
        :joins => nil,
        :group => nil,
        :conditions => [
          "aasm_state = 'active' and (select count(*) from provided_services where provider_id = providers.id and service_id IN (?)) = 3", [1,2,3]],
        :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
        :limit => 10,
        :page => nil)
      Provider.search({:service_ids => [1,2,3]})
    end
    
    it "should search on country" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and country = ?", 'IE'], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:location => 'IE'})
    end
    
    it "should search on state" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and state_province = ?", 'FL'], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:location => 'US-FL'})
    end
    
    it "should search on many countries" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and country IN (?)", ['IE', 'US']], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:countries => ['IE', 'US']})
    end
    
    it "should search on many states" do
      Provider.should_receive(:paginate).with(:joins => nil, :group => nil, :conditions => ["aasm_state = 'active' and state_province IN (?)", ['FL', 'NY']], :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => nil)
      Provider.search({:states => ['FL', 'NY']})
    end
    
    it "should search on many states and many countries" do
      Provider.should_receive(:paginate).with(
        :joins => nil,
        :group => nil,
        :conditions => [
          "aasm_state = 'active' and country IN (?) and if(country = 'US', state_province IN (?), ?)",
            ['IE', 'US'], ['FL', 'NY'], true],
        :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
        :limit => 10,
        :page => nil)
      Provider.search({:countries => ['IE', 'US'], :states => ['FL', 'NY']})
    end
    
    context "hourly rate" do
      it "should search on for a limit" do
        Provider.should_receive(:paginate).with(
          :joins => nil,
          :group => nil,
          :conditions => ["aasm_state = 'active' and hourly_rate >= ? and hourly_rate <= ?", 0, 75],
          :order=>"aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
          :limit=>10,
          :page => nil)
        Provider.search({:hourly_rate => "0-75"})
      end
    end

    context "project length" do
      it "should search on hours per week" do
        Provider.should_receive(:paginate).with(
          :joins => nil,
          :group => nil,
          :conditions => ["aasm_state = 'active' and min_hours <= ? and max_hours >= ?", 0, 10],
          :order=>"aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
          :limit=>10,
          :page => nil)
        Provider.search({:hours => "0-10"})
      end
    end
    
    context "availability" do
      it "should search on availability" do
        Provider.should_receive(:paginate).with(
          :joins => nil,
          :group => nil,
          :conditions => ["aasm_state = 'active' and (select count(*) from bookings where provider_id = providers.id and DATE_FORMAT(date, '%m') = ?) != ?", 12, 31],
          :order=>"aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
          :limit=>10,
          :page => nil)
        Provider.search({:availability => "2009-12-01"})
      end
    end
    
    context "project length" do
      it "should search on project length" do
        Provider.should_receive(:paginate).with(
          :joins => nil,
          :group => nil,
          :conditions => ["aasm_state = 'active' and min_project_length >= ? and max_project_length <= ?", 0, 120],
          :order=>"aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()",
          :limit=>10,
          :page => nil)
        Provider.search({:weeks => "0-4"})
      end
    end
  end
    
  describe "default tech types" do
    before do
      @service = Service.make(:name => "Default", :checked => true)
      @provider = Provider.make(@valid_attributes)
    end
    
    it "should have Default as tech type" do
      @provider.services.include?(@service).should be_true
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
      @provider = Provider.new(@valid_attributes.merge(:users_attributes => {'0' => {
        :password => 'password',
        :password_confirmation => 'password',
        :email => 'dongle@rslw.com',
        :first_name => "Paul",
        :last_name => "Campbell"}}))
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
      @provider = Provider.new(@valid_attributes.merge(
        :email => 'paul@rslw.com',
        :company_url => 'http://www.hypertiny.net',
        :users_attributes => {'0' => {
          :first_name => "Paul",
          :last_name => "Campbell",
          :email => 'paul@rslw.com',
          :password => 'password', 
          :password_confirmation => 'password'}}))
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

describe Provider, "trying to register an empty company name" do
  before do
    p = Provider.make(:company_name => "")
  end
  
  it "should be invalid if I try to register a new one" do
    @provider = Provider.make_unsaved(:company_name => "")
    @provider.should be_valid
  end
  
  it "should use my name to create a slug" do
    @provider = Provider.make_unsaved(:company_name => "")
    @provider.user = User.make(:first_name => "Paul", :last_name => "Campbell")
    @provider.should be_valid
    @provider.slug.should == "paul-campbell"
  end
  
  it "shouldn't use the same slug twice" do
    Provider.make(:company_name => "Jim")
    @provider = Provider.make(:company_name => "Jim")
    @provider.slug.should == 'jim-1'
  end
end

describe Provider, "with bookings" do
  describe "#booked_for" do
    before do
      @provider = Provider.make
      (Date.today.beginning_of_month..Date.today.end_of_month).each do |day|
        @provider.bookings << Booking.make(:date => day)
      end
    end
    
    it "should be booked for this month" do
      @provider.booked_for(Date.today).should be_true
    end
    
    it "should not be booked for next month" do
      @provider.booked_for(1.month.from_now).should_not be_true
    end
  end
end

describe Provider, "with services" do
  describe "#languages" do
    before do
      c = ServiceCategory.make(:name => "Spoken Languages")
      @english = Service.make(:category => c, :name => "English")
      @provider = Provider.make
      @provider.services << @english
    end
    
    it "should add that service to the providers languages" do
      @provider.languages.should == [@english]
    end
  end
  
  describe "#accepted_payment_methods" do
    before do
      c = ServiceCategory.make(:name => "Accepted Payment Methods")
      @paypal = Service.make(:category => c, :name => "Paypal")
      @provider = Provider.make
      @provider.services << @paypal
    end
    
    it "should add that service to the providers languages" do
      @provider.accepted_payment_methods.should == [@paypal]
    end
  end
  
  
end