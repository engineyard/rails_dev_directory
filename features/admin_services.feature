Feature: Managing services

  As an Engine Yard administrator
  I want to be able to add and remove services
  So that I can adapt the system to new tech types as they are required without modifying code
  
  Scenario: Managing services
    Given a logged in admin user
      And a service category "Programming Languages"
      And I am on the admin dashboard
      And there are no services
    When I follow "Services"
      And I follow "Add a New Service"
      And I fill in "Name" with "Java"
      And I check "service[checked]"
      And I press "Save"
    Then I should see "Service category can't be blank"
    When I select "Programming Languages" from "Category"
      And I press "Save"
    Then I should see "Java"
    
    When I follow "Edit"
      And I fill in "Name" with "Ruby on Rails"
      And I press "Save"
    Then I should see "Ruby on Rails"
    
    When I follow "Delete"
      Then I should not see "Ruby on Rails"
    