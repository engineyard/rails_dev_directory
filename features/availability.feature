Feature: Availability
  In order to show that I am booked up
  As a freelancer
  I want to be able to fill out dates that I'm not available
  
  Background:
    Given the date is "December 2009"
      And a provider "Kooky" belonging to "paul@dopo.com"
      And provider "Kooky" is booked up for "January 2010"
      And I am on the homepage
      And I log in as "paul@dopo.com" with password "testtest"
  
  Scenario: Blocking off time
    When I follow "Availability"
      And I check "2009-12-12"
      And I check "2009-12-13"
      And I press "Save Changes"
      And I select "8 Hours/Week" from "Minimum Hours Per Week"
      And I select "40 Hours/Week" from "Maximum Hours Per Week"
      And I fill in "Minimum Hours in Project" with "5"
      And I fill in "Maximum Hours in Project" with "500"
      And I press "Save Changes"
    Then the "2009-12-12" checkbox should be checked
      And the "2009-12-13" checkbox should be checked
      
  Scenario: Checking off entire month
    When I follow "Profile"
    Then I should see "Accepting Work" within "#December"
      And I should see "Booked" within "#January"