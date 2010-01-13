Feature: Retaking a Quiz
  In order to get my account listed
  As a developer
  I want to be able to retake a quiz if I failed it already.
  
  Background:
    Given an inactive provider "Paul Campbell" belonging to "paul@rslw.com"
      And a quiz "Hyper Monkeys"
      And quiz "Hyper Monkeys" has "2" questions total, "1" at a time
      And question "Who's the man?" is on the "Hyper Monkeys" quiz
      And question "Who's the man?" has answer "Me"
      And question "Who's the man?" has answer "You"
      And answer "Me" is the correct answer to "Who's the man?"
      And question "Is pink pink?" is on the "Hyper Monkeys" quiz
      And question "Is pink pink?" has answer "Yes"
      And question "Is pink pink?" has answer "No"
      And answer "No" is the correct answer to "Is pink pink?"
      And "Paul Campbell" failed the "Hyper Monkeys" quiz
      
    Scenario:
      Given I am on the homepage
        And I log in as "paul@rslw.com" with password "testtest"
        And I follow "Quizzes"
      Then I should see "Your Score"
  