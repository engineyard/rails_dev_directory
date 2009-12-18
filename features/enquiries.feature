Feature: Enquiries
  In order to contact a dev
  As a customer
  I want to be able to make an enquiry
  
  Scenario: Contacting a dev
    Given an "active" provider "Paul Campbell"
      And I am on the homepage
      And I follow "Full Listing"
      And I follow "Paul Campbell"
      And I follow "Contact Developer"
    Then I should see "Paul Campbell"
    