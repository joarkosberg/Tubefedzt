require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/^I am on the root page$/) do
  visit root_path
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |form, argument|
  fill_in "#{form}", with: "#{argument}"
  fill_in "#{form}", with: "#{argument}"
end

When(/^I press "([^"]*)"$/) do |button|
  click_button("#{button}")
end

Then(/^I should see the following welcome message "([^"]*)"$/) do |arg1|
  expect(page).to have_content("Welcome in, you are awesome!")
end
