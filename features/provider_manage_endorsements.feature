Feature: Managing recommendations on an account
  As a provider
    I want to be able to approve, reject, and view recommendations
      So that I can control which recommendations appear on my directory entry

  Scenario: Approving a recommendation for display
    Given a provider "Hotpocket" belonging to "paul@oi.net"
      And "Hotpocket" has a new recommendation from "George Tenet"
      And I am on the homepage
    When I log in as "paul@oi.net" with password "testtest"
      And I follow "See All Endorsements"
    Then I should see "George Tenet"
      And I should see "new"
    When I follow "George Tenet"
      And I press "Approve"
    Then I should see "Recommendation saved successfully"
