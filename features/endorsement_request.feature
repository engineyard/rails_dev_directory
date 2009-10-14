Feature: Request an Endorsement
  As a Provider
  I want to be able to request that former customers endorse my services
  
  Scenario: Make a request
    Given a provider "Hashrocket" belonging to "Olenska@chicka.net"
    When I am on the homepage
      And I log in as "Olenska@chicka.net" with password "testtest"
      Then I should see "Ask a customer for an endorsement"
    When I follow "Ask a customer for an endorsement"
      And I fill in "endorsement_request[recipients]" with "Brian Flanagan <btflanagan@gmail.com>, Walter Sobchak <wsobchak@sobchaksecurity.us>, Ezra Gustafson <ezra.gustafson@gmail.com>"
      And I fill in "endorsement_request[message]" with "Hi Friends and Loved Ones!"
      And I press "endorsement_request_submit"
    Then I should see "endorsement_request.submission.thanks_for_requesting" translation
      And I should see "Brian Flanagan"
      And I should see "Walter Sobchak"
      And I should see "Ezra Gustafson"
    When I follow "dashboard.all_recommendations" translation
    Then I should see "Brian Flanagan"
      And I should see "Walter Sobchak"
      And I should see "Ezra Gustafson"
      And I should see "Hi Friends and Loved Ones!"
