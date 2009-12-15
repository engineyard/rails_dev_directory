As a Provider
I want to be able to complete a quiz
So that my listing will show as confirmed

  Background:
    Given a quiz "ActiveRecord callbacks"
      And the quiz "ActiveRecord callbacks" has a question "When is before_save called?" with the following answers:
      | answer        |
      | after update  |
      | before saving |
      And the answer "before saving" is the correct answer for question "When is before_save called?"
      And the quiz "ActiveRecord callbacks" has a question "When is after_save called?" with the following answers:
      | answer        |
      | Never         |
      | after saving  |
      And the answer "before saving" is the correct answer for question "When is after_save called?"
    Given an inactive provider "HyperTiny" belonging to "paul@rslw.com"

  Scenario: Provider has no quiz results
    Given I am on the homepage
      And I log in as "paul@rslw.com" with password "testtest"
    When I follow "Profile"
    Then I should see "No quizzes have been passed yet."

  Scenario: Provider fails a quiz
    Given I am on the homepage
      And I log in as "paul@rslw.com" with password "testtest"
    When I follow "Profile"
      And I follow "Quizzes"
      And I follow "Take this quiz"
    When I press "Finished!"
    Then I should see "Please answer all questions"
    When I choose "Never"
      And I choose "after update"
    Then I should see "You have failed the quiz"
      And I should see "1 correct answers"
      And I should see "2 questions"
      And the provider "HyperTiny" should be inactive
    When I follow "Try again"
    Then I should see "ActiveRecord callbacks"

  Scenario: Provider passes a quiz
    Given I am on the homepage
      And I log in as "paul@rslw.com" with password "testtest"
    When I follow "Profile"
      And I follow "Take a quiz"
      And I select "ActiveRecord callbacks" from "Quiz"
      And I press "Next"
    Then I should see "When is before_save called?"
    When I choose "before saving"
      And I press "Next"
    Then I should see "When is after_save called?"
    When I choose "after saving"
      And I press "Next"
    Then I should see "You have passed the quiz"
      And I should not see "Try again"
      And the provider "HyperTiny" should be active
    When I follow "Profile"
      And I follow "Take a quiz"
    Then I should see "There are currently no quizzes available"
