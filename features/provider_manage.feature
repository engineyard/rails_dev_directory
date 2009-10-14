As a Provider
I want to be able manage my account
So that I can make sure my profile is accurate and up-to-date

  Scenario: Provider manages their account
    Given a provider "Kooky" belonging to "paul@dopo.com"
      And I am on the homepage
    When I log in as "paul@dopo.com" with password "testtest"
      And I follow "navigation.company" translation
      And I follow "company_profile.edit" translation
      Then I should see "company_profile.edit_headline" translation
    When I fill in "provider.street_address" translation with "Market Street"
      And I press "forms.save" translation
    Then I should see "company_profile.updated_successfully" translation