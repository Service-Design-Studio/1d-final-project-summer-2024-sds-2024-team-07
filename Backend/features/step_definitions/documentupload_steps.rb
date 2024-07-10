Given('I am a salaried employee of more than 3 months') do
  # hais
end

When('I want to find the documents I\'m required to upload') do
  # sighpie
end

Then('I should be able to see 3 different buttons for the different employment status') do
  expect(page).to have_button('Salaried Employer A: More than 3 Months')
  expect(page).to have_button('Salaried Employer B: Less than 3 months')
  expect(page).to have_button('Self-Employed/Commision-Based')
end

And('I should be able to click onto the Salaried Employee A button') do
  find_button('Salaried Employer A: More than 3 Months').click
end

When('I click on the Salaried Employee A button') do
  click_button('Salaried Employer A: More than 3 Months')
end

Then("I should be able to see a {string} information") do |info_type|
  case info_type
  when "Passport"
    expect(page).to have_css('img[alt="Passport"]')
  else
    raise "Unknown information type: #{info_type}"
  end
end

Then('I should be able to click onto the {string} tab') do |tab_name|
  case tab_name
  when "Employment Pass"
    find('label[for="tab2"]').click
  when "Income Tax"
    find('label[for="tab3"]').click
  when "Pay Slip"
    find('label[for="tab4"]').click
  when "Proof of Address"
    find('label[for="tab5"]').click
  else
    raise "Unknown tab: #{tab_name}"
  end
end

And('I should be able to see {string} information') do |info_type|
  case info_type
  when "Employment Pass"
    expect(page).to have_css('img[alt="Employment Pass"]', visible: true)
  when "Income Tax"
    expect(page).to have_css('img[alt="Income Tax"]', visible: true)
  when "Pay Slip"
    expect(page).to have_css('img[alt="Pay Slip"]', visible: true)
  when "Proof of Address"
    expect(page).to have_css('img[alt="Proof of Address"]', visible: true)
  else
    raise "Unknown information type: #{info_type}"
  end
end

Then('I should see those same documents on the sidebar under Documents') do
  expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Valid Passport')
  expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Valid Employment Pass')
  expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Income Tax')
  expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Pay Slip')
  expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Proof of Singapore Address')
end

Given('I am a salaried employee of less than 3 months') do
  # hais
end

And('I should be able to click onto the Salaried Employee B button') do
  find_button('Salaried Employer B: Less than 3 months').click
end

When('I click on the Salaried Employee B button') do
  click_button('Salaried Employer B: Less than 3 months')
end

Then('I should be able to see 4 documents: Passport, Employment Pass, PaySlip and Proof of Address') do
  expect(page).to have_content('Valid Passport')
  expect(page).to have_content('Valid Employment Pass')
  expect(page).to have_content('Pay Slip')
  expect(page).to have_content('Proof of Singapore Address')
end

Given('I am a commissioned-Based Employee/Self-Employed') do
  # hais
end

And('I should be able to click onto the Self-Employed or Commision-Based button') do
  find_button('Self-Employed/Commision-Based').click
end

When('I click on the Self-Employed or Commision-Based button') do
  click_button('Self-Employed/Commision-Based')
end

Given("that I am at the document upload page") do
  visit pages_documentupload_path
end

When('I want to find the documents I am required to upload') do
  # sighpie
end

Then('I should be able to click on the Document side bar') do
  expect(page).to have_css('.sidebar .nav-links .icon-link a', text: '1. Documents', visible: true)
end

When('I click on to the Document side bar') do
  find('.sidebar .nav-links .icon-link a', text: '1. Documents').click
end

Then('I should see the documents required for Salaried Employer A') do
  expect(page).to have_content('Valid Passport')
  expect(page).to have_content('Valid Employment Pass')
  expect(page).to have_content('Income Tax')
  expect(page).to have_content('Pay Slip')
  expect(page).to have_content('Proof of Singapore Address')
end

And('I should be able to click on the Salaried Employer B') do
  find_button('Salaried Employer B: Less than 3 months').click
end

When('I click on to the Salaried Employer B button') do
  click_button('Salaried Employer B: Less than 3 months')
end

Then('I should see the documents required for Salaried Employer B') do
  expect(page).to have_content('Valid Passport')
  expect(page).to have_content('Valid Employment Pass')
  expect(page).to have_content('Pay Slip')
  expect(page).to have_content('Proof of Singapore Address')
end

And('I should be able to click on to the Self-Employed or Commision-Based button') do
  find_button('Self-Employed/Commision-Based').click
end

When('I click on to the Self-Employed or Commision-Based button') do
  click_button('Self-Employed/Commision-Based')
end

Then('I should see the documents required for Self-Employed or Commision-Based button') do
  expect(page).to have_content('Valid Passport')
  expect(page).to have_content('Valid Employment Pass')
  expect(page).to have_content('Income Tax')
  expect(page).to have_content('Proof of Singapore Address')
end