Given(/^I am logged in$/) do
  visit root_path
  fill_in 'user_email', with: 'test@test.test'
  fill_in 'user_password', with: 'testtest'
  click_button('Log in')
end

Then(/^I should see results for "([^"]*)"$/) do |keyword|
  expect(page).to have_content("Results for '#{keyword}'")
end
