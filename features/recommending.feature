Feature: Recommending a provider
  As a customer of a provider
  I want to be able to submit a recommendation for a company
  So that I can show my appreciation
  
  As an EY admin
  I want customers to submit their details (name, company, email, url) before submitting a recommendation
  So that the system will be at least partially protected from gaming
  
  As a provider
  I want to approve a recommendation before it appears on the site
  So that I don't get spammed
  
  Scenario: Leaving a recommendation for a provider
    Given an "active" provider "Hashrocket"
      And "Hashrocket" has an approved recommendation "Sweet" "3.days.ago"
      And "Hashrocket" has an approved recommendation "Awesome" "3.days.ago"
      And "Hashrocket" has an approved recommendation "Very good" "2.days.ago"
      And "Hashrocket" has an approved recommendation "Super cool" "1.day.ago"
      And "Hashrocket" has a new recommendation "Nice work" "1.day.ago"
    When I am on the homepage
      And I follow "Find a Rails Developer"
      And I press "Find a developer"
      And I follow "Hashrocket"
    Then I should see "Read all endorsements"
    When I follow "Write an endorsement"
      Then I should see "Satisfied customer? Endorse this developer"
    When I fill in "recommendation[name]" with "Brian Flanagan"
      And I select "2007" from "recommendation[year_hired]"
      And I fill in "recommendation[company]" with "Coral Made"
      And I fill in "recommendation[email]" with "btf@coralmade.net"
      And I fill in "recommendation[url]" with "coralmade.net"
      And I fill in "recommendation[position]" with "Vice President of Human Resources"
      And I fill in "recommendation[endorsement]" with "80% perfect"
      And I press "recommendation_submit"
    Then I should see "Thanks for submitting your endorsement."
      And I should not see "80% perfect"
      And I should not see "Nice work"
    When I follow "more-endorsements"
      Then I should not see "Nice work"
      
  Scenario: A provider with lots of recommendations
    Given an "active" provider "Hashrocket"
      And "Hashrocket" has a new recommendation "Nice work" "3.days.ago"
      And "Hashrocket" has a new recommendation "Very good" "2.days.ago"
      And "Hashrocket" has a new recommendation "Super cool" "1.day.ago"
      And "Hashrocket" has an approved recommendation "Nonchalent" "4.days.ago"
      And "Hashrocket" has an approved recommendation "Awesome" "3.days.ago"
      And "Hashrocket" has an approved recommendation "Deadly" "2.days.ago"
      And "Hashrocket" has an approved recommendation "OK" "1.day.ago"
    When I am on the homepage
      And I follow "Find a Rails Developer"
      And I press "Find a developer"
      And I follow "Hashrocket"
    Then I should see "Read all endorsements"
    When I follow "more-endorsements"
    Then I should not see "Nice work"
      And I should not see "Very good"
      And I should not see "Nice work"
      And I should see "Awesome"
      And I should see "Deadly"
      And I should see "OK"
        
  Scenario: Approving a recommendation for display
    Given a provider "Hotpocket" belonging to "paul@test.com"
      And "Hotpocket" has a rejected recommendation from "Nick Riviera"
      And I am on the homepage
    When I log in as "paul@test.com" with password "testtest"
    Then I should see "Nick Riviera"
    When I follow "Nick Riviera"
      And I press "Approve"
    Then I should see "Recommendation saved successfully"

  Scenario: Viewing provider endorsements
    Given a provider "Hotpocket" belonging to "paul@test.com"
      And "Hotpocket" has an approved recommendation "Vaguely competent service." "3.days.ago"
      And "Hotpocket" has a rejected recommendation "Literally crap. Totally awful. Barely even Ruby." "2.days.ago"
      And I am on the homepage
    When I follow "Find a Rails Developer"
      And I press "Find a developer"
      And I follow "Hotpocket"
    Then I should see "Vaguely competent service"
      And I should not see "Literally crap."
