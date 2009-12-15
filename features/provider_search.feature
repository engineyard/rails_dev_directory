Feature: Provider directory
  As a user
  I want to be able to browse through providers, 30 per page
  I want to be able to request an RFP from a provider
  So that I can find the providers that I like
  
  Background:
    Given an "active" provider "Paul Campbell"
      And "Paul Campbell" has a new endorsement from "George Tenet"
      And "Paul Campbell" has a minimum budget of "15000"
      And "Paul Campbell" has an hourly rate of "150"
      And pre checked services "Ruby on Rails"
      And primary services "AJAX, Visual design, UI"
      And "Paul Campbell" provides "AJAX"
      And "Paul Campbell" provides "UI"
      And an "inactive" provider "Boolio"

  Scenario: Finding a Freelancer by hourly rate
    When I am on the homepage
      And I press "Find a freelance developer"
      And I select "<$75" from "Hourly Rate"
      And I press "Update"
    Then I should not see "Paul Campbell"
    When I select ">$150" from "Hourly Rate"
      And I press "Update"
    Then I should see "Paul Campbell"

  Scenario: Finding a Freelancer by skill set
    When I am on the homepage
      And I check "AJAX"
      And I press "Find a freelance developer"
    Then I should see "Paul Campbell"

    When I am on the homepage
      And I check "AJAX"
      And I check "UI"
      And I press "Find a freelance developer"
    Then I should see "Paul Campbell"

    When I am on the homepage
      And I check "AJAX"
      And I check "Visual design"
      And I press "Find a freelance developer"
    Then I should not see "Paul Campbell"

    When I am on the homepage
      And I check "Visual design"
      And I press "Find a freelance developer"
    Then I should not see "Paul Campbell"

  Scenario: Searching by location
    Given an "active" provider "Hyper Tiny"
      And an "active" provider "Hashrocket"
      And "Hashrocket" is based in "FL, US"
      And "Hyper Tiny" is based in "NA, IE"
    When I am on the homepage
      And I select "All Locations" from "Location"
      And I press "Find a freelance developer"
    Then I should see "Hyper Tiny"
      And I should see "Hashrocket"
    
    When I select "Ireland" from "Location"
      And I press "Update"
    Then I should see "Hyper Tiny"
      And the "Location" field should contain "IE"
      And I should not see "Hashrocket"
    When I select "Florida" from "Location"
      And I press "Update"
    Then I should see "Hashrocket"
      And I should not see "Hyper Tiny"
      
  Scenario: Searching by project length
    Given provider "Paul Campbell" is available for projects between "4" and "8" weeks in length
    
    When I am on the homepage
      And I select "4-8 Weeks" from "Project Length"
      And I press "Find a freelance developer"
    Then I should see "Paul Campbell"
      And the "Project Length" field should contain "4-8"
    
    When I select "1-4 Weeks" from "Project Length"
      And I press "Update"
    Then I should not see "Paul Campbell"

  Scenario: Searching by project length
    Given provider "Paul Campbell" likes to work between "15" and "25" hours per week

    When I am on the homepage
      And I select "15-25 Hours/Week" from "Hours Per Week"
      And I press "Find a freelance developer"
    Then I should see "Paul Campbell"
      And the "Hours Per Week" field should contain "15-25"

    When I select "<15 Hours/Week" from "Hours Per Week"
      And I press "Update"
    Then I should not see "Paul Campbell"

  Scenario: Searching by availability
    Given the date is "15 December 2009"
      And I am on the homepage
      And provider "Paul Campbell" is booked up for "December 2009"
    When I am on the homepage
      And I select "December" from "Availability"
      And I press "Find a freelance developer"
    Then I should not see "Paul Campbell"
    When I select "January" from "Availability"
      And I press "Update"
    Then I should see "Paul Campbell"