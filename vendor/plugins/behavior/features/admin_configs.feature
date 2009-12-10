Feature: Editing Configuration
  In order to set configuration variables in my app
  As a user
  I want to be able to see what configuration is available, and edit it
  
  Scenario: Editing configuration
    Given I am on the configuration page
    Then I should see "Site Admin"
      And I should see "Email Address"
    
    When I fill in "Email Address" with "paul@rslw.com"
      And I press "Save"
    Then I should see "Config Changes Saved"