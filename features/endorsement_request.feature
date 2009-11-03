Feature: Request an Endorsement
  As a Provider
  I want to be able to request that former customers endorse my services
  
  Scenario: Make a request
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      Then I should see "Ask a customer for an endorsement"
    When I follow "Ask a customer for an endorsement"
      And I fill in "endorsement_request[endorser_addresses]" with "Brian Flanagan <btflanagan@gmail.com>, Walter Sobchak <wsobchak@sobchaksecurity.us>, Ezra Gustafson <ezra.gustafson@gmail.com>"
      And I fill in "endorsement_request[message]" with "Hi Friends and Loved Ones!"
      And I press "endorsement_request_submit"
    Then I should see "Your request has been sent to the following recipients:"
      And I should see "Brian Flanagan"
      And I should see "Walter Sobchak"
      And I should see "Ezra Gustafson"
    When I follow "See All Endorsements"
    Then I should see "Brian Flanagan"
      And I should see "Walter Sobchak"
      And I should see "Ezra Gustafson"
      And I should see "Hi Friends and Loved Ones!"
      And I log out

    When I go to the new endorsement page for "Hashrocket"
    Then I should see "Please follow the URL you received"

    Then "btflanagan@gmail.com" should receive an email
    When I open the email
      And I click the first link in the email
    Then I should see "Please let us know your experience with Hashrocket"
    When I fill in "Your name" with "Brian Flanagan"
      And I select "2009" from "Year you hired Hashrocket"
      And I fill in "Your company at the time" with "Flanagan Design"
      And I fill in "Company website" with "http://www.flanagan.ie"
      And I fill in "Your position at the time" with "CEO"
      And I fill in "Your email" with "thewrongaddress@gmail.com"
      And I fill in "Write your endorsement" with "They were teh bomb."
      And I press "Submit endorsement"
    Then I should see "Please enter the email address that received the request"
    When I fill in "Your email" with "btflanagan@gmail.com"
      And I press "Submit endorsement"
    Then I should see "Thanks for submitting your endorsement"
