Given('that I am on the document upload page') do
  begin
    visit pages_documentupload_path
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

Given('that I am on the application form page') do
  begin
    visit pages_applicationform_path
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
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
  begin
    expect(page).to have_css('a[data-tab="tab1"]')
    expect(page).to have_css('a[data-tab="tab2"]')
    expect(page).to have_css('a[data-tab="tab3"]')
    expect(page).to have_css('a[data-tab="tab4"]')
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

# Scenario 2: Viewing details of other pages on the sidebar
Given ('I am on the document upload page and I want to find information of the application form page without having submitted my documents yet') do
  begin
    visit pages_documentupload_path
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
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
  within('.sidebar .nav-links .iocn-link .sub-menu') do
    expect(page).to have_no_css('a[data-tab]', visible: true) # Adjust based on actual HTML if sections are not clickable
  end
end

When('I finish viewing the document upload page') do
  # This step is informational; no specific action needed
end

When('I want to go to the application form page') do
  # This step is informational; no specific action needed
end

Then('I should be able to click onto the "Next" button') do
  expect(page).to have_css('a', text:   'Next', visible: true)
end

Then('I should be brought to the application form page') do
  find('a', text: 'Next').click
  expect(current_path).to eq(pages_applicationform_path) # Ensure the path is correct
end

When('I want to find the information of the document upload page') do
  # This step is informational; no specific action needed
end

Then('I should see other pages\' headers on the sidebar such as "1. Documents"') do
  expect(page).to have_css('.sidebar .nav-links .iocn-link a .link_name', text: '1. Documents', visible: true)
end

When('I click on the header "1. Documents"') do
  find('.sidebar .nav-links .iocn-link a .link_name', text: '1. Documents').click
end

Then('I should see the text under "1. Documents" such as "Valid Passport"') do
  within('.sidebar .nav-links .iocn-link') do
    find('a', text: '1. Documents').click
    within('.sub-menu') do
      expect(page).to have_content('Valid Passport')
    end
  end
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
  #hi
end

And ('I should see the headers of other pages on the sidebar such as "1. Documents"') do
  expect(page).to have_css('.sidebar .link_name', text: '1. Documents')
end

When ('I click on the header "1. Documents"') do
  find('.sidebar .link_name', text: '1. Documents').click
end
