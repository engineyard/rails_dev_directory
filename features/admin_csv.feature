Feature: CSV Dumps
  As an adminstrator
  I want a CSV dump for visitors that submit requests
  So that I can export to salesforce
  
  Scenario: CSV dump of Requests
    Given a provider "Hyper tiny" with an RFP called "Help me"
      And a logged in admin user
    When I am on the admin dashboard
      And I follow "CSV exports"
      And I follow "Export Requests"
    Then I should see "Help me"
    When I am on the admin dashboard
      And I follow "CSV exports"
      And I follow "Export Providers"
    Then I should see "Hyper tiny"