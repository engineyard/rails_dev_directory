As a Provider
I want to be able sign up
So that I can can receive Rails project referrals

  Scenario: Signing up with an invalid password confirmation
    Given I am on the homepage
      And I follow "Create an account"
      And I fill in the provider sign up form for "Pivotpaul Labs"
      And I fill in the "First name" with "JD"
      And I fill in the "Last name" with "Crow"
      And I fill in the "Email" with "jdcrow@oleopry.com"
      And I fill in the "Password" with "dingusday"
      And I fill in the "Retype password" with "greasycoat"
      And I fill in the "provider[marketing_description]" with "The human mind can only stand so much."
      And I fill in the "Company email" with "theboys@oleopry.com"
      And I fill in the "Company website" with "ole opry"
      And I check "provider[terms_of_service]"
    When I press "Sign up"
    Then I should see "Password doesn't match confirmation"
      And I should see "Please enter a valid URL"
    When I fill in the "password" with "americanpolka"
      And I fill in the "Retype password" with "americanpolka"
      And I fill in the "Company website" with "oleopry.com"
      And I press "Sign up"
    Then I should see "Pivotpaul Labs Admin"
    When I follow "Profile"
    Then I should see "The human mind can only stand so much."

  Scenario: Signing up and sloppily missing the TOS
    Given I am on the homepage
      And a service category "Programming"
      And a service category "Design"
      And the following services:
      | category    | service       |
      | Programming | Ruby on Rails |
      | Programming | AJAX         |
      | Design      | Visual design |
      | Design      | UI            |
    When I follow "Create an account"
      And I fill in the provider sign up form for "Pivotpaul Labs"
      And I fill in the "provider[marketing_description]" with "Some things are too hot to touch."
    Then I should see "Ruby on Rails"
    When I check "Ruby on Rails"
      And I check "Visual design"
      And I press "Sign up"
    Then I should see "Terms of Use"
    When I check "provider[terms_of_service]"
      And I press "Sign up"
    Then I should see "Pivotpaul Labs Admin"
    When I follow "Profile"
    Then I should see "Ruby on Rails"
      And I should see "Some things are too hot to touch."
