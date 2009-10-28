Feature: Admin dashboard
  As an Engine Yard admin
  I want to see statistics on generated content in my dashboard
  So that when I log in I can immediately see exciting and important metrics
  
  Scenario: Admin dashboard
    Given a provider "Lehman Bros"
      And a provider "AIG"
      And a provider "Wachovia"
      And a logged in admin user
    When I am on the admin dashboard
    Then I should see "3 active"

  Scenario: Change password
    Given a logged in admin user
    When I am on the admin dashboard
      And I follow "Change Password"
      And I fill in "user_password" with "kablamo"
      And I press "Save"
    Then I should see "User saved successfully"
