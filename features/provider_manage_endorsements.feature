Feature: Managing endorsements on an account
  As a provider
    I want to be able to approve, reject, and view endorsements
      So that I can control which endorsements appear on my directory entry

  Scenario: Approving a endorsement for display
    Given a provider "Hotpocket" belonging to "paul@oi.net"
      And "Hotpocket" has a new endorsement from "George Tenet"
      And I am on the homepage
    When I log in as "paul@oi.net" with password "testtest"
      And I follow "See All Endorsements"
    Then I should see "George Tenet"
      And I should see "new"
    When I follow "George Tenet"
      And I press "Approve"
    Then I should see "Endorsement saved successfully"
