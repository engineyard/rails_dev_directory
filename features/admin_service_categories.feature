Feature: Managing service categories

  As an Engine Yard administrator
  I want to be able to add and remove service categories
  So that I can adapt the system to new kinds of service as they are required without modifying code
  
  Scenario: Managing service categories
    Given a logged in admin user
      And I am on the admin dashboard
      And there are no service categories
    When I follow "Services"
      And I follow "Manage Categories"
    Then I should see "No categories have been added yet"
    
    When I follow "Add a New Category"
      And I press "Save"
    Then I should see "Name can't be blank"
    When I fill in "Name" with "Programming"
      And I press "Save"
    Then I should see "Programming"
    
    When I follow "Edit"
      And I fill in "Name" with "Programming Languages"
      And I press "Save"
    Then I should see "Programming Languages"
    
    When I follow "Delete"
      Then I should not see "Programming Languages"
