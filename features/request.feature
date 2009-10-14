Feature: Reading an Request
  As a Provider
  I want to be able to see which RFPs I've read and which I haven't
  
  Scenario: Clicking through to RFPs from the dashboard
    Given a provider "Hashrocket" belonging to "obie@hashrocket.com"
      And an RFP called "New site for French Laundry" for "Hashrocket"
    When I am on the homepage
      And I log in as "obie@hashrocket.com" with password "testtest"
      Then I should see "New site for French Laundry"
    When I follow "New site for French Laundry"
      Then I should see "New site for French Laundry"
      And I should see "interesting project"
    When I follow "navigation.rfps" translation
      Then I should see "New site for French Laundry"
    When I follow "New site for French Laundry"
      Then I should see "New site for French Laundry"
        And I should see "interesting project"