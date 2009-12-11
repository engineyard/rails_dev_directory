# Feature: Customer leaves feedback
#   In order to let others know how a provider did
#   As a customer
#   I want to leave feedback about my experience with the provider
# 
#   Scenario: Customer leaves feedback, provider accepts it
#     Given a provider "HyperTiny" belonging to "paul@rslw.com"
#       And the provider "HyperTiny" has the email address "it@hypertiny.com"
#       And I am on the profile page for "HyperTiny"
#     When I follow "Leave feedback"
#       And I fill in "Your name" with "Rob Holland"
#       And I select "2009" from "Year you hired HyperTiny"
#       And I fill in "Your company at the time" with "Engine Yard"
#       And I fill in "Your position at the time" with "Developer"
#       And I fill in "Your email" with "developer@engineyard.com"
#       And I fill in "Project" with "Building a website"
#       And I fill in "Message" with "They wore awesome T-Shirts"
#       And I press "Leave feedback"
#     Then I should see "Feedback saved. HyperTiny will be notified"
#     When I am on the profile page for "HyperTiny"
#     Then I should not see "Rob Holland"
#       And "it@hypertiny.com" should have an email
#     When I open the email
#     Then I should see "feedback" in the email subject
#       And I should see "Rob Holland" in the email body
#       And I should see "Building a website" in the email body
#       And I should see "developer@engineyard.com" in the email body
#       And the feedback about "Building a website" should be new
#     When I click the first link in the email
#       And I fill in "Email" with "paul@rslw.com"
#       And I fill in "Password" with "testtest"
#       And I press "Sign in"
#     Then I should see "Feedback"
#     When I choose "Accept"
#       And I press "Save"
#     Then I should see "Rob Holland"
#       And I should see "They wore awesome T-Shirts"
# 
#   Scenario: Provider rejects some feedback
#     Given a provider "HyperTiny" belonging to "paul@rslw.com"
#       And the provider "HyperTiny" has some rejected feedback "They are a bit hairy"
#     When I am on the profile page for "HyperTiny"
#     Then I should not see "They are a bit hairy"
#       And I should see "No feedback"