Feature: Top Cities
  In order to see the top cities in the director
  As a user
  I want to be able to browse the top cities in the directory
  
  Scenario: Browsing top cities
    Given a top city "Dublin" in "IE"
      And a top city "Jacksonville" in "FL, US"
      And an "active" provider "Hashrocket"
      And "Hashrocket" is located in "Jacksonville, FL, US"
    When I am on the homepage
      And I follow "Top Cities"
      And I follow "Dublin"
    Then I should not see "Hashrocket"
    
    When I follow "Top Cities"
      And I follow "Jacksonville"
    Then I should see "Hashrocket"
      
      