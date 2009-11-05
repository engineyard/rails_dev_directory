Feature: Manage Portfolio Items
  As a Provider
  I want to be able to create, read, update, and delete portfolio items

  Scenario: New from empty
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
      When I am on the homepage
        And I log in as "Olenska@chicka.net" with password "testtest"
        And I follow "Profile"
        And I follow "You can add one now"
      Then I should see "Year Completed"

  Scenario: Create a portfolio item
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      And I follow "Profile"
      And I follow "Manage portfolio"
      And I follow "Add a new project to your portfolio"
      And I fill in "Name" with "CF Martin"
      And I fill in "portfolio_item_url" with "http://www.cfmartin.com"
      And I fill in "Description" with "We really screwed the pooch on that one."
      And I select "2007" from "portfolio_item[year_completed]"
      And I press "Save"
    Then I should see the translation for "portfolio_item.saved_successfully"
      And I should see "CF Martin"

  Scenario: Edit a portfolio item
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
      And a portfolio item "Fire and Grace" belonging to the "Hashrocket" provider
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      And I follow "Profile"
      And I follow "Manage portfolio"
      And I follow "Fire and Grace"
      And I follow "Edit this portfolio project"
      And I fill in "Name" with "Tim Stafford"
      And I fill in "portfolio_item_url" with "http://www.bluehighwayband.com"
      And I fill in "Description" with "Through the window of a train"
      And I select "2005" from "portfolio_item[year_completed]"
      And I press "Save"
    Then I should see the translation for "portfolio_item.saved_successfully"
      And I should see "Tim Stafford"
      And I should not see "Fire and Grace"

  Scenario: Deleting a portfolio item
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
      And a portfolio item "Fire and Grace" belonging to the "Hashrocket" provider
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      And I follow "Profile"
      And I follow "Manage portfolio"
      And I follow "Fire and Grace"
      And I follow "Edit this portfolio project"
    When I press "Delete this portfolio project"
    Then I should see "Portfolio project deleted successfully"
      And I should not see "Fire and Grace"

  Scenario: Adding one too many items
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
      And a portfolio item "Fire and Grace" belonging to the "Hashrocket" provider
      And a portfolio item "Corn Flakes" belonging to the "Hashrocket" provider
      And a portfolio item "Sounds True" belonging to the "Hashrocket" provider
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      And I follow "Profile"
      And I follow "Manage portfolio"
      And I follow "Add a new project to your portfolio"
    Then I should see the translation for "portfolio_item.validations.too_many"
      And I should not see "Add a new portfolio item for Hashrocket"
