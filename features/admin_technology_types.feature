Feature: Managing technology types

  As an Engine Yard administrator
  I want to be able to add and remove technology types
  So that I can adapt the system to new tech types as they are required without modifying code
  
  Scenario: Managing technology types
    Given a logged in admin user
      And I am on the admin dashboard
      And there are no technology types
    When I follow "navigation.technology_types" translation
    Then I should see "technology_type.no_types" translation
    When I follow "technology_type.add_new" translation
      And I fill in "technology_type.name" translation with "Java"
      And I check "technology_type[checked]"
      And I press "forms.save" translation
    Then I should see "Java"
    
    When I follow "general.edit" translation
      And I fill in "technology_type.name" translation with "Ruby on Rails"
      And I press "forms.save" translation
    Then I should see "Ruby on Rails"
    
    When I follow "general.delete" translation
      Then I should not see "Ruby on Rails"
    