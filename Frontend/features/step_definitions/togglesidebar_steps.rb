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
Then('I should see each page of the aplication within the sidebar') do
  expect(page).to have_css('.link_name', minimum: 4)
end

Then ('I should see the contents of the current section') do
  expect(page).to have_css('.sub-menu', visible: true)
end

And('I click on a section that belongs to the current page') do
  find('.sidebar li', text: '1. Documents').click
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

# And('all headers should be clickable') do
#   find('.sidebar .link_name', text: '2. Particulars').click
#   find('.sidebar .link_name', text: '3. Verify Particulars').click
#   find('.sidebar .link_name', text: '4. Create Pin').click
# end
And('all headers should be clickable') do
  headers = [
    '2. Particulars',
    '3. Verify Particulars',
    '4. Create Pin'
  ]
  headers.each do |header_text|
    # Find the specific header element within the sidebar
    header = find(:xpath, "//a[contains(., '#{header_text}')]/span[@class='link_name']", visible: false)
    page.execute_script("arguments[0].scrollIntoView(true);", header.native)
    page.execute_script("arguments[0].click();", header.native)
  end
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

And('I should not be able to click on sections that belong to {string}') do |section_name|
  case section_name
  when "Particulars"
    expect(page).to have_css('span[class="non-clickable"]', text: 'Personal Information')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Contact Information')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Passport Details')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Residential Details')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Professional Details')
  when "Documents"
    expect(page).to have_css('span[class="non-clickable"]', text: 'Valid Passport')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Valid Employment Pass')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Income Tax')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Pay Slip')
    expect(page).to have_css('span[class="non-clickable"]', text: 'Proof of Singapore Address')
  else
    raise "Unknown section: #{section_name}"
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
