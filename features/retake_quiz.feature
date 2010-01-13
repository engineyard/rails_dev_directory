Feature: Retaking a Quiz
  In order to get my account listed
  As a developer
  I want to be able to retake a quiz if I failed it already.
  
  Background:
    Given an inactive provider "Paul Campbell" belonging to "paul@rslw.com"
      And a quiz "ActiveRecord callbacks"
      And the quiz "ActiveRecord callbacks" has a question "When is before_save called?" with the following answers:
      | answer        |
      | after update  |
      | before saving |
      And the answer "before saving" is the correct answer for question "When is before_save called?"
      And the quiz "ActiveRecord callbacks" has a question "When is after_save called?" with the following answers:
      | answer        |
      | Never         |
      | after saving  |
      And the answer "after saving" is the correct answer for question "When is after_save called?"
      And "Paul Campbell" failed the "ActiveRecord callbacks" quiz
      
    Scenario: Retaking a Quiz
      Given I am on the homepage
        And I log in as "paul@rslw.com" with password "testtest"
        And I follow "Quizzes"
      Then I should see "Your Score"
        And I should see "Retake Quiz"
      
      When I follow "Retake Quiz"
      Then I should see "ActiveRecord callbacks"