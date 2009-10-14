As an Engine Yard administrator
I want to browse and create portfolio items for providers
So that I can see the activity on the provider account and provide support if necessary

  Scenario: Adding a new portfolio item to a provider
    Given a logged in admin user
      And I am on the admin dashboard
      And a provider "Old Grey Mare"
    When I follow "Developers"
      And I follow "Old Grey Mare"
      And I follow "Add a new project to your portfolio"
      And I fill in "Name" with "Norman Blake"
      And I fill in "portfolio_item_url" with "http://www.normanblake.com"
      And I select "2007" from "portfolio_item[year_completed]"
      And I fill in "Description" with "This project was really easy because we are totally professionals."
      And I press "Save"
    Then I should see "Old Grey Mare"
    
  Scenario: Editing a portfolio item on a provider
    Given a logged in admin user
      And I am on the admin dashboard
      And a provider "Natalie Haas"
      And a portfolio item "Fire and Grace" belonging to the "Natalie Haas" provider
    When I follow "Developers"
      And I follow "Natalie Haas"
      And I follow "Fire and Grace"
    When I fill in "Name" with "In the Moment"
      And I press "Save"
    Then I should see "In the Moment"
      And I should see "Portfolio project saved successfully"
      
  Scenario: Deleting a portfolio item on a provider
    Given a provider "Vowel Movements"
      And a portfolio item "Pure West" belonging to the "Vowel Movements" provider
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Vowel Movements"
      And I follow "Pure West"
    When I press "Delete this portfolio project"
    Then I should see "Portfolio project deleted successfully"
      And I should not see "Pure West"
