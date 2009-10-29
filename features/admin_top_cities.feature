Feature: Admin Top Cities
  In order to choose what top cities appear in the top cities section
  As an admin
  I want to be able to add top cities
  
  Scenario: Managing top cities
    Given a logged in admin user
    When I am on the admin dashboard
      And I follow "Top Cities"
      And I follow "Add Top City"
      And I fill in "City" with "Dublin"
      And I select "Ireland" from "Country"
      And I press "Save"
    Then I should see "Dublin, Ireland"
    
    When I follow "Edit"
      And I fill in "City" with "Galway"
      And I press "Save"
    Then I should see "Galway, Ireland"
    
    When I follow "Delete"
    Then I should not see "Galway, Ireland"