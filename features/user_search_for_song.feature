Feature: User can search for songs
  As a user
  I want to search for a song
  So that I can find a song I want to listen to

  Scenario: User search for a song
    Given I am logged in
    And I fill in "searchWord" with "test"
    When I press "Search"
    Then I should see results for "test"
