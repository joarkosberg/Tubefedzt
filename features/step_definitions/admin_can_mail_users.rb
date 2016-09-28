Given(/^I am logged in as admin$/) do
  visit root_path
  fill_in 'user_email', with: 'admin@tubefedzt.com'
  fill_in 'user_password', with: 'adminadmin'
  click_button('Log in')
end

Given(/^I am on the user page$/) do
  visit pages_user_path
  click_button('collapsible')
end

Then(/^a mail should be sent to all users$/) do
  expect(page).to have_content("Message was sent")
end
