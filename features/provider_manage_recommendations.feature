Feature: Managing recommendations on an account
  As a provider
    I want to be able to approve, reject, and view recommendations
      So that I can control which recommendations appear on my directory entry

  Scenario: Approving a recommendation for display
    Given a provider "Hotpocket" belonging to "paul@oi.net"
      And "Hotpocket" has a new recommendation from "George Tenet"
      And I am on the homepage
    When I log in as "paul@oi.net" with password "testtest"
      And I follow "dashboard.all_recommendations" translation
    Then I should see "George Tenet"
      And I should see "recommendation.states.new" translation
    When I follow "George Tenet"
      And I press "recommendation.approve" translation
    Then I should see "recommendation.saved_successfully" translation