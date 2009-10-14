class State
  
  attr_accessor :code, :name
  
  def initialize(array)
    self.code = array.last
    self.name = array.first
  end
  
  NAMES = [
    [ "Alabama", "AL" ], 
    [ "Alaska", "AK" ], 
    [ "Arizona", "AZ" ], 
    [ "Arkansas", "AR" ], 
    [ "California", "CA" ], 
    [ "Colorado", "CO" ], 
    [ "Connecticut", "CT" ], 
    [ "Delaware", "DE" ], 
    [ "District Of Columbia", "DC" ], 
    [ "Florida", "FL" ], 
    [ "Georgia", "GA" ], 
    [ "Hawaii", "HI" ], 
    [ "Idaho", "ID" ], 
    [ "Illinois", "IL" ], 
    [ "Indiana", "IN" ], 
    [ "Iowa", "IA" ], 
    [ "Kansas", "KS" ], 
    [ "Kentucky", "KY" ], 
    [ "Louisiana", "LA" ], 
    [ "Maine", "ME" ], 
    [ "Maryland", "MD" ], 
    [ "Massachusetts", "MA" ], 
    [ "Michigan", "MI" ], 
    [ "Minnesota", "MN" ], 
    [ "Mississippi", "MS" ], 
    [ "Missouri", "MO" ], 
    [ "Montana", "MT" ], 
    [ "Nebraska", "NE" ], 
    [ "Nevada", "NV" ], 
    [ "New Hampshire", "NH" ], 
    [ "New Jersey", "NJ" ], 
    [ "New Mexico", "NM" ], 
    [ "New York", "NY" ], 
    [ "North Carolina", "NC" ], 
    [ "North Dakota", "ND" ], 
    [ "Ohio", "OH" ], 
    [ "Oklahoma", "OK" ], 
    [ "Oregon", "OR" ], 
    [ "Pennsylvania", "PA" ], 
    [ "Rhode Island", "RI" ], 
    [ "South Carolina", "SC" ], 
    [ "South Dakota", "SD" ], 
    [ "Tennessee", "TN" ], 
    [ "Texas", "TX" ], 
    [ "Utah", "UT" ], 
    [ "Vermont", "VT" ], 
    [ "Virginia", "VA" ], 
    [ "Washington", "WA" ], 
    [ "West Virginia", "WV" ], 
    [ "Wisconsin", "WI" ], 
    [ "Wyoming", "WY" ]
  ]
  
  class << self
    def by_code(code)
      State::NAMES.select { |state| state.last == code }.flatten.first
    end

    def by_name(name)
      State::NAMES.select { |state| state.first == name }.flatten.last
    end
    
    def slugs
      State::NAMES.map { |state| state.first.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-') }
    end
    
    def slug_for(code)
      "us-#{by_code(code).to_s.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-')}"
    end
    
    def path_for(code)
      "#{by_code(code).to_s.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'_')}_path"
    end
    
    def from_slug(slug)
      State.new(State::NAMES.select { |state| state.first.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-') == slug }.flatten)
    end
  end

end