As a developer and EY admin
I want a full listing of endorsements in the admin section
So that examine all submitted endorsements independent of providers

  Scenario: Seeing a list of endorsements
    Given a provider "Tim Stafford" with an approved endorsement from "Steve Martin"
      And a provider "Chris Thile" with a rejected endorsement from "Jimmy Martin"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Endorsements"
      Then I should see "Steve Martin"
      Then I should see "Jimmy Martin"

  Scenario: Viewing a endorsement
    Given a provider "Tim Stafford" with an approved endorsement from "Steve Martin"
      And a provider "Chris Thile" with a rejected endorsement from "Jimmy Martin"
      And a logged in admin user
      And I am on the admin dashboard
      And I follow "Endorsements"
      And I follow "Steve Martin"
    Then I should see "Steve Martin"
			And I should see "Tim Stafford"
			And I should not see "Chris Thile"

  Scenario: Deleting a endorsement
    Given a provider "Tim Stafford" with a rejected endorsement from "Steve Martin"
      And a logged in admin user
    When I am on the admin dashboard  
      And I follow "Endorsements"
      And I follow "Steve Martin"
      And I press "endorsement.admin.delete" translation
    Then I should see "Endorsement deleted successfully"

  Scenario: List should display approved state
      Given a provider "Tim Stafford" with an approved endorsement from "Steve Martin"
        And a provider "Chris Thile" with an approved endorsement from "Jimmy Martin"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "navigation.endorsements" translation
    Then I should see "endorsement.states.approved" translation
      And I should see "endorsement.states.approved" translation
      And I should not see "endorsement.states.rejected" translation

  Scenario: List should display rejected state
      Given a provider "Tim Stafford" with a new endorsement from "Steve Martin"
        And a provider "Chris Thile" with a new endorsement from "Jimmy Martin"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "navigation.endorsements" translation
    Then I should see "endorsement.states.new" translation