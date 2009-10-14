As a developer and EY admin
I want a full listing of rfps in the admin section
So that examine all submitted rfps independent of providers

  Scenario: Seeing a list of rfps
    Given a provider "Tim Stafford" with an RFP called "Unwieldy"
      And a provider "Chris Thile" with an RFP called "Punch"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Requests"
      Then I should see "Unwieldy"
      And I should see "2 requests have been submitted"

  Scenario: Seeing a list of one rfp
    Given a provider "Tim Stafford" with an RFP called "Unwieldy"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Requests"
      Then I should see "Unwieldy"
      And I should see "rfp.rfp_count_singular" translation

  Scenario: Viewing an rfp
    Given a provider "Tim Stafford" with an RFP called "Unwieldy"
      And a logged in admin user
      And I am on the admin dashboard
      And I follow "Requests"
      And I follow "Unwieldy"
    Then I should see "Unwieldy"
			And I should see "Tim Stafford"

  Scenario: Deleting an RFP
    Given a provider "Tim Stafford" with an RFP called "Unwieldy"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "Requests"
      And I follow "Unwieldy"
      And I press "Delete Request"
    Then I should see "rfp.deleted_successfully" translation