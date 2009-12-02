Feature: Provider directory
  As a user
  I want to be able to browse through providers, 30 per page
  I want to be able to request an RFP from a provider
  So that I can find the providers that I like
  
  Scenario: Provider index and requesting an RFP
    Given an "active" provider "Trulio"
      And "Trulio" has a new endorsement from "George Tenet"
      And "Trulio" has a minimum budget of "15000"
      And pre checked services "Ruby on Rails"
      And primary services "AJAX, Visual design, UI"
      And "Trulio" provides "AJAX"
      And an "inactive" provider "Boolio"
    When I am on the homepage
      And I follow "home.find_a_provider" translation
      And I fill in "budget" with "10000"
      And I press "provider.directory.find_providers" translation
    Then I should not see "Trulio"


    When I follow "home.find_a_provider" translation
      And I check "AJAX"
      And I press "provider.directory.find_providers" translation
    Then I should see "Trulio"

    When I follow "home.find_a_provider" translation
      And I check "Visual design"
      And I press "provider.directory.find_providers" translation
    Then I should not see "Trulio"

    When I am on the homepage
      And I follow "home.find_a_provider" translation
      And I fill in "budget" with "20000"
      And I press "provider.directory.find_providers" translation
    Then I should see "Trulio"
      And I should see "Boolio"
    When I press "general.next" translation
      Then I should see "rfp.provider_required" translation
    When I follow "Trulio"
    Then I should see "Trulio"
      And I should not see "Dublin Avenue"
      And I should not see "Dublin 3"
    When I follow "provider.request_rfp" translation
      And I fill in "rfp.first_name" translation with "Paul"
      And I fill in "rfp.last_name" translation with "Campbell"
      And I fill in "rfp.company_name" translation with "Joojoobangbang"
      And I fill in "rfp.postal_code" translation with "90210"
      And I fill in "rfp.email" translation with "paul@rslw.com"
      And I fill in "rfp.phone_number" translation with "0879148162"
      And I fill in "rfp.project_name" translation with "Super secret monster project"
      And I select "$5k-$20k" from "rfp[budget]"
      And I fill in "rfp.start_date" translation with "20 May 2010"
      And I fill in "rfp.duration" translation with "2 weeks"
      And I select "(GMT+00:00) Dublin" from "rfp[time_zone]"
      And I fill in "rfp.office_location" translation with "Dublin"
      And I check "rfp[general_liability_insurance]"
      And I check "rfp[professional_liability_insurance]"
    Then I should see "Ruby on Rails"
    When I check "Visual Design"
      And I check "UI"
      And I press "rfp.submit" translation
    Then I should see "Terms of service must be accepted"
    When I check "rfp[terms_of_service]"
      And I press "rfp.submit" translation
    Then I should see "rfp.submission.thanks_for_submitting" translation
      
  
  Scenario: Selecting multiple providers from within the directory and requesting an RFP
    Given an "active" provider "Brian Flanagan"
      And an "active" provider "Paul Campbell"
    When I am on the homepage
      And I follow "home.find_a_provider" translation
      And I press "provider.directory.find_providers" translation
    Then I should see "Brian Flanagan"
      And I should see "Paul Campbell"
    When I check the "Brian Flanagan" checkbox
      And I check the "Paul Campbell" checkbox
      And I press "next"
    Then I should see "Brian Flanagan"
      And I should see "Paul Campbell"

  Scenario: Searching by location
    Given an "active" provider "Hyper Tiny"
      And an "active" provider "Hashrocket"
      And "Hashrocket" is based in "FL, US"
      And "Hyper Tiny" is based in "NA, IE"
    When I am on the homepage
      And I select "All Locations" from "Location"
      And I press "provider.directory.find_providers" translation
    Then I should see "Hyper Tiny"
      And I should see "Hashrocket"
    When I am on the homepage
      And I select "Ireland" from "Location"
      And I press "provider.directory.find_providers" translation
    Then I should see "Hyper Tiny"
      And I should not see "Hashrocket"
    When I am on the homepage
      And I select "Florida" from "Location"
      And I press "provider.directory.find_providers" translation
    Then I should see "Hashrocket"
      And I should not see "Hyper Tiny"