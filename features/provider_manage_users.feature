Feature: Managing users on an account
  As a provider
    I want to be able to add and remove users on my account
      So that I can share my account with my team members
      
  Scenario: Adding a new user to a provider
    Given a provider "Kooky" belonging to "paul@joy.com"
      And I am on the homepage
    When I log in as "paul@joy.com" with password "testtest"
      And I follow "Users"
      And I follow "Add a new user"
      And I fill in "First name" with "Ciara"
      And I fill in "Last name" with "McGuire"
      And I fill in "Email" with "ciara@ciarascakes.com"
      And I press "Save"
    Then I should see "Ciara McGuire"
    And "ciara@ciarascakes.com" should have a perishable token
    
  Scenario: Editing a user on a provider
    Given a provider "Kooky" belonging to "paul@joy.com"
      And a user "Billow" belonging to the "Kooky" provider
      And I am on the homepage
    When I log in as "paul@joy.com" with password "testtest"
      And I follow "Users"
    Then I should see "billow"
      And I follow "billow"
      And I follow "Edit this user"
    When I fill in "First name" with "Joe"
      And I fill in "Last name" with "Arnold"
      And I press "Save"
    Then I should see "Joe Arnold"
      And I should see "Manage users"
      
  Scenario: Deleting a user on a provider
    Given a provider "Kooky" belonging to "paul@joy.com"
      And a user "Billow" belonging to the "Kooky" provider
      And I am on the homepage
    When I log in as "paul@joy.com" with password "testtest"
      And I follow "Users"
      Then I should see "billow"
    When I follow "billow"
      And I follow "Edit this user"
    Then I should see "Here you can change the user's details"
      And I press "Delete this user"
    Then I should see "Manage users"
    
  Scenario: Regular user can't edit other users
    Given a provider "Kooky" belonging to "paul@joy.com"
      And a user "Billow" belonging to the "Kooky" provider
    When I am on the homepage
      And I log in as "billowlowha@test.com" with password "buxtonbuxton"
      And I follow "Users"
    Then I should not see "Edit"
    