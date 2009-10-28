Feature: Provider directory
  As a user
  I want to be able to browse through providers, 30 per page
  So that I can find the providers that I like
  
  Scenario: Provider index and requesting an RFP
    Given an "active" provider "Trulio"
      And "Trulio" has a new recommendation from "George Tenet"
      And "Trulio" has a minimum budget of "15000"
      And pre checked services "Ruby on Rails"
      And primary services "AJAX, Visual design, UI"
      And "Trulio" provides "AJAX"
      And an "inactive" provider "Boolio"
    When I am on the homepage
      And I follow "home.full_listing" translation
    Then I should see "Trulio"
    Then I should see "Trulio"
    
  Scenario: Provider index by country / state
    Given an "active" provider "Hyper Tiny"
      And "Hyper Tiny" is based in "NA, IE"
      And an "active" provider "Hashrocket"
      And "Hashrocket" is based in "FL, US"
      And an "active" provider "Nonsense"
      And "Nonsense" is based in "nowhere"
    When I am on the homepage
      And I follow "home.by_location" translation
    Then I should see "Ireland"
      And I should see "United States"
      And I should see "Florida"
      And I should not see "Hashrocket"
      And I should not see "Hyper Tiny"
    When I follow "Florida"
      Then I should see "Hashrocket"
    When I follow "home.by_location" translation
      And I follow "Ireland"
    Then I should see "Hyper Tiny"