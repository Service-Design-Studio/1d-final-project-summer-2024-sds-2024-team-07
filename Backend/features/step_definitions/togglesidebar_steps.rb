# features/step_definitions/sidebar_steps.rb

Given('that I have clicked {string}') do |button|
  click_button button
end

When('I see the options for employment type') do
  expect(page).to have_selector('.employment-type-options')
end

Then('I should be able to click the employment type I currently have') do
  find('.employment-type-option').click  # Adjust the selector to match your actual HTML
end

Then('I should be brought to the document upload page') do
  expect(page).to have_current_path('/documentupload')  # Adjust the path to match your actual URL
end

Then('I should see the required documents that I need to upload for my application') do
  expect(page).to have_selector('.required-documents')
end

Then('I should be able to see a sidebar that is open that shows the required information for the form application') do
  expect(page).to have_selector('.sidebar.open')  # Adjust the selector to match your actual HTML
end

Then('I should be able to click on the toggle of the sidebar to close the sidebar') do
  find('.sidebar-toggle').click  # Adjust the selector to match your actual HTML
  expect(page).not_to have_selector('.sidebar.open')
end

Given('that I am on the document upload page') do
  visit '/documentupload'  # Adjust the path to match your actual URL
end

When('I want to find the information of the documents required in the document upload page') do
  expect(page).to have_selector('.sidebar')
end

Then('I should be able to click onto the sidebar') do
  find('.sidebar').click  # Adjust the selector to match your actual HTML
end

Then('I should see information of each section of each page within the sidebar') do
  expect(page).to have_selector('.sidebar .section-info')
end

Then('I click on a section that belongs to the current page') do
  find('.sidebar .current-page-section').click  # Adjust the selector to match your actual HTML
end

Then('my screen slides to the respective section') do
  expect(page).to have_selector('.current-page-section.active')
end

Given('that I have clicked into the document upload page') do
  visit '/documentupload'  # Adjust the path to match your actual URL
end

When('I want to find the information of the application form having not submitted my documents yet') do
  expect(page).to have_selector('.sidebar')
end

Then('I should see other pages headers on the sidebar such as {string}') do |header|
  expect(page).to have_content(header)
end

Then('I should be able to click on the header of the sidebar') do
  find('.sidebar-header').click  # Adjust the selector to match your actual HTML
end

Then('a dropdown displaying the information of the sections within that page should appear') do
  expect(page).to have_selector('.sidebar-header .dropdown-content')
end

Then('I should not be able to click on a section that belongs to that page') do
  expect(page).not_to have_selector('.other-page-section', visible: true)
end
