Feature: Static pages
  As an Engine Yard administrator
  I want to add pages
  So that I can add static content to the site

  Scenario: Adding, editing, deleting pages
    Given a logged in admin user
      And I am on the admin dashboard
    When I follow "navigation.pages" translation
      And I follow "page.add_new" translation
      And I fill in "page[title]" with "New page"
      And I fill in "page[url]" with "new_page"
      And I fill in "page[content]" with "Hello"
      And I press "forms.save" translation
    Then I should see "New page"
    When I follow "New page"
      And I fill in "page[title]" with "Page revision"
      And I press "forms.save" translation
    Then I should see "Page revision"
    When I follow "general.delete" translation
    Then I should not see "Page revision"
      And I should see "page.deleted_successfully" translation
    