Feature: Enquiries
  In order to contact a dev
  As a customer
  I want to be able to make an enquiry
  
  Scenario: Contacting a dev
    Given an "active" provider "Paul Campbell"
      And I am on the homepage
      And I follow "View All"
      And I follow "Paul Campbell"
      And I follow "Contact Developer"
    Then I should see "Paul Campbell"
    
    When I fill in "First Name" with "Joe"
      And I fill in "Last Name" with "Drumgoole"
      And I fill in "Email" with "joe@putplace.com"
      And I check "I accept the Terms of Use"
      And I press "Send"