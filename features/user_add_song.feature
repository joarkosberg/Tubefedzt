Feature: User can add song to playlist
    As a User
    I want to add songs to the playlist
    So that users can vote on them

    Scenario: User adds song to the playlist
      Given I am logged in
      And I am on the search page
      When I add a song
      Then it should be added to the playlist
