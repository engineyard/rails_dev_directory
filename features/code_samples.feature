Feature: Code Samples
  In order to demonstrate my awesome codez
  As a freelancer
  I want to be able to upload code samples
  
  Background:
    Given an inactive provider "HyperTiny" belonging to "paul@rslw.com"
  
  Scenario: Adding a code sample
    Given I am on the homepage
      And I log in as "paul@rslw.com" with password "testtest"
      And I follow "Code"
      And I follow "Upload a Code Sample"
      And I fill in "Name your sample code" with "Twitter2Campfire"
      And I fill in "Paste your code sample here" with "class Twitter2Campfire; end"
      And I press "Review Code"
    Then I should see "class Twitter2Campfire"
    When I press "Test Code"
    Then I should see "Score"