As a developer and EY admin
I want an unrestricted admin section
So that I can edit database fields within the UI of the site

  Scenario: Creating a new provider
    Given a logged in admin user
      And I am on the admin dashboard
      And I follow "Developers"
      And I follow "Add a new developer"
    When I fill in "Company name" with "Pullover"
      And I fill in "City" with "Dublin"
      And I fill in "Company email" with "paul@rslw.com"
      And I fill in "Company website" with "http://www.rslw.com"
      And I press "Save"
    Then I should see "Edit developer"
  
  Scenario: Editing a provider
    Given a provider "Pullover"
      And primary services "Ruby on Rails, AJAX"
      And secondary services "Visual design, UI"
      And a user "paul" belonging to the "Pullover" provider
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Pullover"
      And I follow "Edit developer"
    When I fill in "Company name" with "Gown"
      And I fill in "Street address" with "Market street"
      And I fill in "provider[marketing_description]" with "Cheap, Fast, Reliable"
      And I select "flagged" from "Status"
      And I select "Paul Campbell" from "Account admin"
      And I check "Ruby on Rails"
      And I check "Visual design"
      
      And I press "Save"
    Then I should see "Developer saved successfully"
      And I should see "flagged"
      And I should see "Paul Campbell (Account Admin)"
      And I should see "Cheap, Fast, Reliable"
  
  Scenario: Viewing a provider
    Given a provider "Pullover"
      And a logged in admin user
      And I am on the admin dashboard
      And I follow "Developers"
      And I follow "Pullover"
    Then I should see "Pullover"
  
  Scenario: Seeing a list of providers
    Given a provider "Jimbo"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Developers"
      Then I should see "Jimbo"
      And I should see "active"
      
  Scenario: Deleting a provider
    Given a provider "HJ"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Developers"
      And I follow "HJ"
      And I press "Delete this provider"
    Then I should see "Developer deleted successfully"
