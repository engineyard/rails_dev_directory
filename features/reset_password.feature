Feature: Reset password
  As a provider
  I want a forgot password function
  So that passwords are never sent plain text
  
  Scenario: Requesting a password reset
    Given a user "paul@rslw.com"
    When I am on the homepage
      And I follow "provider.sign_in" translation
      And I follow "user.forgot_password" translation
    And I fill in "email" with "jo@armstrong.net"
      And I press "user.send_new_password" translation
    Then I should see "user.not_found" translation
    When I fill in "email" with "paul@rslw.com"
      And I press "user.send_new_password" translation
    Then I should see "user.password_reset_sent" translation
    
  Scenario: Creating a new password
    Given a user "paul@rslw.com"
    When I follow my reset password link for "paul@rslw.com"
    Then I should see "user.set_new_password" translation
    When I fill in "user[password]" with "bilbo"
      And I fill in "user[password_confirmation]" with "bilbo"
      And I press "user.save_new_password" translation
    Then I should see "user.password_updated" translation
    Then I should see "Paul"