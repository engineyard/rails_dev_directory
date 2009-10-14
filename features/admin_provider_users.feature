As an Engine Yard administrator
I want to browse and create users for providers
So that I can see the activity on the provider account and provide support if necessary

  Scenario: Adding a new user to a provider
    Given a logged in admin user
      And I am on the admin dashboard
      And a provider "Hashrocket"
    When I follow "Developers"
      And I follow "Hashrocket"
      And I follow "Add a new user"
      And I fill in "First name" with "Ciara"
      And I fill in "Last name" with "McGuire"
      And I fill in "Email" with "ciara@ciarascakes.com"
      And I fill in "Password" with "mcguire"
      And I press "Save"
    Then I should see "Hashrocket"
      And I should see "user.take_control" translation
      And I should see "Ciara McGuire"
    When I follow "user.take_control" translation
    Then I should see "Ciara"
    
  Scenario: Editing a user on a provider
    Given a logged in admin user
      And I am on the admin dashboard
      And a provider "Crushtastic"
      And a user "paul" belonging to the "Crushtastic" provider
    When I follow "Developers"
      And I follow "Crushtastic"
      And I follow "test@test.com"
      And I follow "user.edit" translation
    When I fill in "First name" with "Joe"
      And I fill in "Last name" with "Arnold"
      And I press "Save"
    Then I should see "Joe Arnold"
      And I should see "User saved successfully"
      
  Scenario: Deleting a user on a provider
    Given a provider "Billow"
      And a user "paul" belonging to the "Billow" provider
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Billow"
      And I follow "test@test.com"
      And I follow "user.edit" translation
    When I press "Delete this user"
    Then I should see "User deleted successfully"