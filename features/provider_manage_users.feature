Feature: Managing user account
  As a provider
  I want to be able to edit my details
  So that I can share my account with my team members
      
  Scenario: Adding a new user to a provider
    Given a provider "Kooky" belonging to "paul@joy.com"
      And I am on the homepage
    When I log in as "paul@joy.com" with password "testtest"
      And I follow "My Account"
      And I fill in "First name" with "Ciara"
      And I fill in "Last name" with "McGuire"
      And I fill in "Email" with "ciara@ciarascakes.com"
      And I fill in "Password" with "nomchomp"
      And I fill in "Retype Password" with "nomchomp"
      And I press "Save"
    Then I should see "Ciara"
    And "ciara@ciarascakes.com" should have a perishable token