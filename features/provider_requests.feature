As an Engine Yard administrator
I want to see the RFPs that a provider has generated
So that I can monitor the performance of the system

  Scenario: Viewing RFPs for a particular provider
    Given a provider "Jinglicious" with an RFP called "Nice work finger"
    Given a provider "Tim Stafford" with an RFP called "Through the window of a train"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Jinglicious"
      And I follow "provider.rfps" translation
    Then I should see "Nice work finger"	
    Then I should not see "Through the window of a train"
    When I follow "Nice work finger"
    Then I should see "It's such an interesting project, what do you think?"
  
  Scenario: Deleting an RFP
    Given a provider "Willy Wallow" with an RFP called "Spamtastic"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Developers"
      And I follow "Willy Wallow"
      And I follow "provider.rfps" translation
      And I follow "Spamtastic"
      And I press "Delete Request"
    Then I should see "rfp.deleted_successfully" translation