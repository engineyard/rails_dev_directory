Feature: User administration
  As an Engine Yard administrator
  I want to add, edit, delete users
  So that I can have full control over site access

  Scenario: Adding, editing, deleting users
    Given a logged in admin user
      And I am on the admin dashboard
    When I follow "navigation.users" translation
      And I follow "user.add_new" translation
      And I fill in "user[first_name]" with "Rodney"
      And I fill in "user[last_name]" with "Miller"
      And I fill in "user[email]" with "rmiller@rodneymiller.net"
      And I fill in "user[password]" with "blank"
      And I press "forms.save" translation
    Then I should see "Rodney Miller"
      And "rmiller@rodneymiller.net" should have a perishable token
    When I follow "user.edit" translation
      And I fill in "user[first_name]" with "Elvie"
      And I press "forms.save" translation
    Then I should see "Elvie Miller"  
    When I follow "navigation.users" translation
      And I follow "general.delete" translation
    Then I should not see "Elvie Miller"
      And I should see "user.deleted_successfully" translation
