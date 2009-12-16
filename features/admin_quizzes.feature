As an Engine Yard administrator
I want to browse and create quizzes for providers
So that developers can prove they know a thing or two about rails

  Scenario: Managing quizzes
    Given a logged in admin user
      And I am on the admin dashboard
    When I follow "Quizzes"
      And I follow "Add a new Quiz"
      And I press "Save"
    Then I should see "Name can't be blank"
    When I fill in "Name" with "ActiveRecord callbacks"
      And I press "Save"
    Then I should see "ActiveRecord callbacks"
    
    When I follow "Edit"
      And I fill in "Name" with "ActiveRecord observers"
      And I press "Save"
      And I follow "Quizzes"
    Then I should see "ActiveRecord observers"
    
    When I follow "Delete"
      Then I should not see "ActiveRecord observers"

  Scenario: Adding a question to a quiz
    Given a quiz "ActiveRecord callbacks"
      And a logged in admin user
      And I am on the admin dashboard
    When I follow "Quizzes"
      And I follow "ActiveRecord callbacks"
      And I fill in "Question" with "When is the before_save callback called?"
      And I fill in "Answer 1" with "10am"
      And I press "Save"
      And I fill in "Answer 2" with "Another answer"
      And I press "Save"
      And I select "10am" from "Correct Answer"
      And I press "Save"
    Then I should see "Quiz saved"
