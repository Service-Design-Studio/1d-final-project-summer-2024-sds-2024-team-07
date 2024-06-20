# features/step_definitions/sidebar_steps.rb
Given('I am on the document upload page') do
  visit('/documentupload')
end

When('I want to find the information of the documents required on the document upload page') do
  # This step is informational; no specific action needed
end

Then('I should be able to click onto the sidebar') do
  expect(page).to have_css('.sidebar', visible: true)
end

Then('I should see information of each section of each page within the sidebar') do
  expect(page).to have_css('.sidebar .nav-links .iocn-link', minimum: 1)
end

When('I click on a section that belongs to the current page') do
  find('.sidebar .nav-links .iocn-link', text: 'Documents').click
end

Then('my screen slides to the respective section') do
  expect(page).to include('#tab1') # Adjust the hash based on the actual section ID
  expect(page).to include('#tab2')
  expect(page).to include('#tab3')
  expect(page).to include('#tab4')
end
