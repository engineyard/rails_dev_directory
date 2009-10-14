Feature: Sending a custom welcome to users
  As an EY admin
  I want to be able to send a custom welcome message to a user
  So that they don't think it's spam

  Scenario: Sending a custom welcome message to a user
    Given a provider "Billow"
      And a user "paul" belonging to the "Billow" provider
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Billow"
      And I follow "test@test.com"
      And I fill in "message" with "It's a nice day"
      And I press "user.send_welcome_message" translation
    Then I should see "user.welcome_message_sent" translation