Feature: User can log in
    As a User
    I want to log in
    So that I can add or vote for songs

    Scenario: User logs in
      Given I am on the root page
      And I fill in "user_email" with "test@test.test"
      And I fill in "user_password" with "testtest"
      When I press "Log in"
      Then I should see the following welcome message "Welcome in, you are awesome!"
