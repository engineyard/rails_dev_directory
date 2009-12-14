Feature: Recommending a provider
  As a customer of a provider
  I want to be able to submit a endorsement for a company
  So that I can show my appreciation
  
  As an EY admin
  I want customers to submit their details (name, company, email, url) before submitting a endorsement
  So that the system will be at least partially protected from gaming
  
  As a provider
  I want to approve a endorsement before it appears on the site
  So that I don't get spammed
  
  Scenario: Leaving a endorsement for a provider
    Given an "active" provider "Hashrocket"
      And "Hashrocket" has an approved endorsement "Sweet" "3.days.ago"
      And "Hashrocket" has an approved endorsement "Awesome" "3.days.ago"
      And "Hashrocket" has an approved endorsement "Very good" "2.days.ago"
      And "Hashrocket" has an approved endorsement "Super cool" "1.day.ago"
      And "Hashrocket" has a new endorsement "Nice work" "1.day.ago"
    When I am on the homepage
      And I press "Find a freelance developer"
      And I follow "Hashrocket"
    Then I should see "Read all endorsements"
    Given "Hashrocket" have requested "Brian Flanagan <btf@coralmade.net>" submit an endorsement
      And "btf@coralmade.net" follows the emailed endorsement link
    Then I should see "Satisfied customer? Endorse this developer"
    When I fill in "endorsement[name]" with "Brian Flanagan"
      And I select "2009" from "endorsement[year_hired]"
      And I fill in "endorsement[company]" with "Coral Made"
      And I fill in "endorsement[email]" with "btf@coralmade.net"
      And I fill in "endorsement[url]" with "coralmade.net"
      And I fill in "endorsement[position]" with "Vice President of Human Resources"
      And I fill in "endorsement[endorsement]" with "80% perfect"
      And I press "endorsement_submit"
    Then I should see "Thanks for submitting your endorsement."
      And I should not see "80% perfect"
      And I should not see "Nice work"
    When I follow "more-endorsements"
      Then I should not see "Nice work"
      
  Scenario: A provider with lots of endorsements
    Given an "active" provider "Hashrocket"
      And "Hashrocket" has a new endorsement "Nice work" "3.days.ago"
      And "Hashrocket" has a new endorsement "Very good" "2.days.ago"
      And "Hashrocket" has a new endorsement "Super cool" "1.day.ago"
      And "Hashrocket" has an approved endorsement "Nonchalent" "4.days.ago"
      And "Hashrocket" has an approved endorsement "Awesome" "3.days.ago"
      And "Hashrocket" has an approved endorsement "Deadly" "2.days.ago"
      And "Hashrocket" has an approved endorsement "OK" "1.day.ago"
    When I am on the homepage
      And I press "Find a freelance developer"
      And I follow "Hashrocket"
    Then I should see "Read all endorsements"
    When I follow "more-endorsements"
    Then I should not see "Nice work"
      And I should not see "Very good"
      And I should not see "Nice work"
      And I should see "Awesome"
      And I should see "Deadly"
      And I should see "OK"
        
  Scenario: Approving a endorsement for display
    Given a provider "Hotpocket" belonging to "paul@test.com"
      And "Hotpocket" has a rejected endorsement from "Nick Riviera"
      And I am on the homepage
    When I log in as "paul@test.com" with password "testtest"
    Then I should see "Nick Riviera"
    When I follow "Nick Riviera"
      And I press "Approve"
    Then I should see "Endorsement saved successfully"

  Scenario: Viewing provider endorsements
    Given a provider "Hotpocket" belonging to "paul@test.com"
      And "Hotpocket" has an approved endorsement "Vaguely competent service." "3.days.ago"
      And "Hotpocket" has a rejected endorsement "Literally crap. Totally awful. Barely even Ruby." "2.days.ago"
      And I am on the homepage
      And I press "Find a freelance developer"
      And I follow "Hotpocket"
    Then I should see "Vaguely competent service"
      And I should not see "Literally crap."
