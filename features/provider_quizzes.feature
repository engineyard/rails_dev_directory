As a Provider
I want to be able to complete a quiz
So that my listing will show as confirmed

  Background:
    Given a quiz "ActiveRecord callbacks"
      And the quiz "ActiveRecord callbacks" should be completed in "5" minutes
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
      And quiz "ActiveRecord callbacks" has "2" questions total, "2" at a time
    Given an inactive provider "HyperTiny" belonging to "paul@rslw.com"
      And I am on the homepage
      And I log in as "paul@rslw.com" with password "testtest"

  Scenario: Provider has no quiz results
    When I follow "Profile"
    Then I should see "No Quizzes Taken Yet"
    
  Scenario: Provider runs out of time
    Given the time is "3:00"
      And I follow "Profile"
      And I follow "Quizzes"
      And I follow "Take this quiz"
      And the time is "3:06"
      And I press "Finished!"
    Then I should see "You have run out of time!"

  Scenario: Provider fails a quiz
    When I follow "Profile"
      And I follow "Quizzes"
      And I follow "Take this quiz"
    When I press "Finished!"
    Then I should see "Answer can't be blank"
    When I choose "Never"
      And I choose "after update"
      And I press "Finished!"
    Then I should see "0 / 2"
      And the provider "HyperTiny" should be inactive

  Scenario: Provider passes a quiz
    When I follow "Profile"
      And I follow "Take a quiz"
      And I follow "Take this quiz"
    Then I should see "When is before_save called?"
    When I choose "before saving"
      And I choose "after saving"
      And I press "Finished!"
    Then I should see "2 / 2"
      And the provider "HyperTiny" should be active
    When I follow "Profile"
      And I follow "Take a quiz"
    Then I should not see "Take this quiz"
