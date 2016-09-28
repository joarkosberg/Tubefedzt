require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/^I am on the search page$/) do
  fill_in 'searchWord', with: 'kygo'
  click_button('Search')
end

When(/^I add a song$/) do
  # Get the first title in search results
  get_first_title

  click_link('s0')

  visit songs_path
end

Then(/^it should be added to the playlist$/) do
  expect(page).to have_content(get_first_title)
end
