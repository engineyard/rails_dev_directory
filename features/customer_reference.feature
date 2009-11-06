Feature: Customer requests a reference
  In order to get a feeling for a freelancer's work
  As a potential customer
  I want to hear from a previous customer

  Scenario: Customer requests a reference
    Given a provider "HyperTiny"
      And "HyperTiny" has an approved endorsement "Excellent" "1.days.go"
      And I am on the profile page for "HyperTiny"
    Then I should see "Excellent"
  
