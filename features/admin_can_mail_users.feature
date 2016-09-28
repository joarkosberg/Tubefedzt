Feature: Admin can send mail to all users
    As an admin
    I want to send mail to all the users
    So that I can inform them about important events

   Scenario: Admin sends mail
     Given I am logged in as admin
     And I am on the user page
     And I fill in "subject" with "This is a test"
     And I fill in "message" with "This is a test"
     When I press "Send"
     Then a mail should be sent to all users
