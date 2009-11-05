As a Provider
I want to be able manage my account
So that I can make sure my profile is accurate and up-to-date

  Background:
    Given a service category "Stack"
      And a service category "Programming Languages"
      And the service category "Programming Languages" has proficiency
      And the following services:
      | category              | service |
      | Programming Languages | Ruby    |
      | Programming Languages | Python  |

  Scenario: Provider manages their account
    Given a provider "Kooky" belonging to "paul@dopo.com"
      And I am on the homepage
    When I log in as "paul@dopo.com" with password "testtest"
      And I follow "Profile"
      And I follow "Edit company profile"
      Then I should see "Edit your company profile"
    When I fill in "Street Address" with "Market Street"
      And I fill in "Minimum Hours" with "5"
      And I fill in "Maximum Hours" with "10"
      And I fill in "Hourly rate" with "150"
      And I check "Ruby"
      And I choose "Programming Languages Ruby Intermediate"
      And I press "Save"
    Then I should see "Thanks for updating your profile"
      And I should see "Minimum Hours"
      And I should see "5"
      And I should see "Maximum Hours"
      And I should see "10"
      And I should see "Hourly Rate"
      And I should see "150"
      And I should not see "Stack"
      And I should see "Programming Languages"
      And I should see "Ruby"
      And I should see "Intermediate"
      And I should not see "Python"
    When I follow "Edit company profile"
    Then the "Ruby" checkbox should be checked
      And the "Programming Languages Ruby Intermediate" checkbox should be checked
      And the "Python" checkbox should not be checked
      
