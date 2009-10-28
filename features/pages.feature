Feature: Static pages
  As an Engine Yard administrator
  I want to add pages
  So that I can add static content to the site

  Scenario: Adding, editing, deleting pages
    Given a logged in admin user
      And I am on the admin dashboard
    When I follow "Pages"
      And I follow "Add a new page"
      And I fill in "page[title]" with "New page"
      And I fill in "page[url]" with "new_page"
      And I fill in "page[content]" with "Hello"
      And I press "Save"
    Then I should see "New page"
    When I follow "New page"
      And I fill in "page[title]" with "Page revision"
      And I press "Save"
    Then I should see "Page revision"
    When I follow "Delete"
    Then I should not see "Page revision"
      And I should see "Page deleted"
    