Feature: Adding arbitrary content to areas of already existant pages
  As a designer
  I want to be able to dynamically change the header of the provider signup form
  So that I try out different designs
  
    Scenario: Adding content to the homepage by creating a page with a url of 'home'
      Given a page "Home" with url "home"
        And page "Home" has content "Oh, I like that"
      When I am on the homepage
      Then I should see "Oh, I like that"
      
    Scenario: Adding content to the provider signup page by creating a page with a url of 'provider-signup'
      Given a page "Provider signup" with url "providers/new"
        And page "Provider signup" has content "Oh, I LOVE that"
      When I am on the homepage
        And I follow "Create an account"
      Then I should see "Oh, I LOVE that"