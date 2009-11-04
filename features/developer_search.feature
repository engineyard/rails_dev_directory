Feature: Searching for a developer
  In order to find developers with specific skills
  As a user
  I want to narrow my search with skill filters
  
  Background:
    Given primary services "Rails, Visual Design"
      And an "active" provider "Hashrock"
      And an "active" provider "Clearright"
      And "Hashrock" provides "Rails"
      And "Clearright" provides "Visual Design"
    
  Scenario: Searching one criteria
    When I am on the homepage
      And I fill in "Your Budget" with "50000"
      And I check "Rails"
      And I press "Find a developer"
    Then I should see "Hashrock"
      And I should not see "Clearright"
      
  Scenario: Searching another criteria
    When I am on the homepage
      And I fill in "Your Budget" with "50000"
      And I check "Visual Design"
      And I press "Find a developer"
    Then I should see "Clearright"
      And I should not see "Hashrock"
      
  Scenario: Searching all criteria
    When I am on the homepage
      And I fill in "Your Budget" with "50000"
      And I check "Visual Design"
      And I check "Rails"
      And I press "Find a developer"
    Then I should not see "Clearright"
      And I should not see "Hashrock"
      