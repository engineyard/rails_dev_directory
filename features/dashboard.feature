Feature: Provider dashboard
  As a Provider
  I want to see my account overview on the dashboard
  So that when I login I can see information that is important to me without digging for it
  
  Scenario: Provider dashboard
    Given a provider "Hyper Tiny" belonging to "paul@inimici.com"
      And an RFP called "Help us!" for "Hyper Tiny"
      And "Hyper Tiny" has a new endorsement from "Tom Rowley"
      And "Hyper Tiny" has a new endorsement from "Mike Foley"
      And I am on the homepage
    When I log in as "paul@inimici.com" with password "testtest"
      Then I should not see "Help us!"
      And I should see "Tom Rowley"
      And I should see "Mike Foley"
