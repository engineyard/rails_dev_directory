Feature: Reset password
  As a provider
  I want a forgot password function
  So that passwords are never sent plain text
  
  Scenario: Requesting a password reset
    Given a user "paul@rslw.com"
    When I am on the homepage
      And I follow "Sign in to your account"
      And I follow "Forgot your password?"
    And I fill in "email" with "jo@armstrong.net"
      And I press "Send"
    Then I should see "No user was found with that email address"
    When I fill in "email" with "paul@rslw.com"
      And I press "Send"
    Then I should see "Instructions to reset your password have been emailed to you. Please check your email."
    
  Scenario: Creating a new password
    Given a user "paul@rslw.com"
    When I follow my reset password link for "paul@rslw.com"
    Then I should see "Set a new password"
    When I fill in "user[password]" with "bilbo"
      And I fill in "user[password_confirmation]" with "bilbo"
      And I press "Save new password"
    Then I should see "Password successfully updated"
    Then I should see "Paul"
