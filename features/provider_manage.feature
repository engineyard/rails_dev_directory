As a Provider
I want to be able manage my account
So that I can make sure my profile is accurate and up-to-date

  Scenario: Provider manages their account
    Given a provider "Kooky" belonging to "paul@dopo.com"
      And I am on the homepage
    When I log in as "paul@dopo.com" with password "testtest"
      And I follow "Company"
      And I follow "Edit company profile"
      Then I should see "Edit your company profile"
    When I fill in "Street Address" with "Market Street"
      And I fill in "Minimum Hours" with "5"
      And I fill in "Maximum Hours" with "10"
      And I press "Save"
    Then I should see "Thanks for updating your profile"
      And I should see "Minimum Hours"
      And I should see "5"
      And I should see "Maximum Hours"
      And I should see "10"
