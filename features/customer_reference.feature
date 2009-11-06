Feature: Customer requests a reference
  In order to get a feeling for a freelancer's work
  As a potential customer
  I want to hear from a previous customer

  Scenario: Potential customer requests a reference
    Given a provider "HyperTiny"
      And "HyperTiny" has an approved endorsement from "theclient@formerclient.com"
      And I am on the profile page for "HyperTiny"
    When I follow "Request a reference"
      And I fill in "Name" with "Rob"
      And I fill in "Email" with "theclient@anothercustomer.com"
      And I fill in "Message" with "Do they have mad Agile skillz?"
      And I press "Request reference"
    Then "theclient@formerclient.com" should receive an email
    When I open the email
    Then I should see "provide a reference" in the email subject
      And I should see "Do they have mad Agile skillz?" in the email body
    When I click the first link in the email
    Then I should see "Do they have mad Agile skillz?"
    When I fill in "Message" with "Their Agile skillz are teh bomb"
      And I press "Send reference"
    Then I should see "Thanks"
      And "theclient@anothercustomer.com" should receive an email
    When I open the email
    Then I should see "received a reference" in the email subject
      And I should see "Their Agile skillz are teh bomb" in the email body
