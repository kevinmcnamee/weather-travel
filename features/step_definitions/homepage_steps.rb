Given(/^I visit the homepage$/) do
  visit root_path
end

When(/^I enter my zip code in the from field$/) do
  fill_in('From', with: '45440')
end

When(/^I enter a zip code in the to field$/) do
  fill_in('To', with: '07506')
end

When(/^I press Submit$/) do
  click_on('Submit')
end

Then(/^I should see the current weather$/) do
  expect(page).to have_content('Current weather from 45440 to 07506')
end
