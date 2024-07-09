Given('that I am on the document upload page') do
  visit pages_documentupload_path
end
Given('that I am on the application form page') do
  visit pages_applicationform_path
end


# Scenario 1: Viewing details within the same page on the sidebar
Then('I should see the sidebar') do
  expect(page).to have_css('.sidebar', visible: true)
end

Then('I should see each page of the aplication within the sidebar') do
  expect(page).to have_css('.link_name', minimum: 4)
end

Then ('I should see the contents of the current section') do
  expect(page).to have_css('.sub-menu', visible: true)
end

And('I click on a section that belongs to the current page') do
  find('.sidebar .link_name', text: '1. Documents').click
end

Then('my screen slides to the respective section') do
  # Verify the section visibility
  expect(page).to have_css('a[data-tab="tab1"]')
  expect(page).to have_css('a[data-tab="tab2"]')
  expect(page).to have_css('a[data-tab="tab3"]')
  expect(page).to have_css('a[data-tab="tab4"]')
end

# Scenario 2: Viewing details of other pages on the sidebar
Given ('I want to find the information of the other pages without having submitted my documents yet') do
end

Then("I should see other pages' headers on the sidebar") do
  expect(page).to have_css('.link_name', text: '4. Create Pin')
end



And('all headers should be clickable') do
  find('.sidebar .link_name', text: '2. Particulars').click
  find('.sidebar .link_name', text: '3. Verify Particulars').click
  find('.sidebar .link_name', text: '4. Create Pin').click
end

And ('I should see information of each section of each page within the sidebar') do
  expect(page).to have_css('.sub-menu', visible: true)
end

When ('I click on the header "2. Particulars"') do
  find('.sidebar .link_name', text: '2. Particulars').click
end

Then('a dropdown displaying the information of the sections within that page should appear') do
  expect(page).to have_css('.sidebar .sub-menu', visible: true)
end

Then('I should not be able to click on a section that belongs to that page') do
  begin
    within('.sidebar .nav-links .iocn-link .sub-menu') do
      expect(page).to have_no_css('a[data-tab]', visible: true) # Adjust based on actual HTML if sections are not clickable
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end


# Scenario 3: Viewing details of document upload page on the sidebar from application page
When ('I want to find the information of the document upload page') do

end

And ('I should see the headers of other pages on the sidebar such as "1. Documents"') do
  expect(page).to have_css('.sidebar .link_name', text: '1. Documents')
end

When ('I click on the header "1. Documents"') do
  find('.sidebar .link_name', text: '1. Documents').click
end
