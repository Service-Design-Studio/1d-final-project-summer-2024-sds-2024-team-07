Given('I am on the document upload page') do
  begin
    visit pages_documentupload_path
  rescue ActionController:: RoutingError => e
    puts "Ignoring routing error:  #{e.message}"
  end
end

  Then('I should see that I am on the tab for "Salaried Employee for more than 3 months"') do
    expect(page).to have_css('button#button1.active', text: /Salaried Employee\s*:\s*More\s*than\s*3\s*Months/)
  end

# #Click on other employment types
# When('')

When('I click "Upload {string}" button') do |button|
  case button
  when "Passport"
    find('label[for="uploadButton1"]').click
  when "Employment Pass"
    find('label[for="uploadButton2"]').click
  when "Income Tax"
    find('labbel[for="uploadButton3"]').click
  when "Pay Slip"
    find('labbel[for="uploadButton4"]').click
  when "Proof of Address"
    find('labbel[for="uploadButton5"]').click
  else
    raise "Unknown button: #{button}"
  end
end

And('I should be able to choose a file corresponding to {string}') do |file|
  case file
  when "Passport"
    attach_file('fileInput1', Rails.root.join('features', 'support', 'test_images', 'passport.jpg'), make_visible: true)
  when "Employment Pass"
    attach_file('fileInput2', Rails.root.join('features', 'support', 'test_images', 'employment_pass.png'), make_visible: true)
  when "Income Tax"
    attach_file('fileInput3', Rails.root.join('features', 'support', 'test_images', 'income_tax.png'), make_visible: true)
  when "Pay Slip"
    attach_file('fileInput4', Rails.root.join('features', 'support', 'test_images', 'pay_slip.png'), make_visible: true)
  when "Proof of Address"
    attach_file('fileInput5', Rails.root.join('features', 'support', 'test_images', 'proof_of_address.jpg'), make_visible: true)
  else
    raise "Unknown file: #{file}"
  end
end

Then('I should be able to close the alert') do
  save_and_open_screenshot # This will take a screenshot and open it in your browser
  accept_alert do
    # No additional actions are necessary here; accept_alert will handle it.
  end
end

Then('I should see {string}') do |file_name|
  expect(page).to have_content(file_name)
end

# Then('I should see "Document Uploaded"')

# Then('I should not be able to click on the "Next" button') do
#   next_button = find("#nextButton")
#   expect(next_button[:style]).to include('pointer-events: none')
#   expect(next_button[:style]).to include('opacity: 0.5')
# end

# When('I click "Next" button') do
#   find("#nextButton").click
# end

# Then('I should be brought to the applicatipn form page') do
#   visit pages_file_documentupload_path
# end

# #Scenario: Wrong file type document upload
# And('I am uploading for any document')

When('I navigate to the {string} tab') do |tab|
  case tab
  when "Passport"
    find('label[for="label1"]').click
  when "Employment Pass"
    find('label[for="label2"]').click
  when "Income Tax"
    find('label[for="label3"]').click
  when "Pay Slip"
    find('label[for="label4"]').click
  when "Proof of Address"
    find('label[for="label5"]').click
  else
    raise "Unknown tab: #{tab_name}"
  end
end

When('I upload a document with the following details:') do |table|
  table.hashes.each do |row|
    document_type = row['Document Type']
    upload_button_text = row['Upload Button Text']
    file_input_id = row['File Input ID']

    invalid_file_path = Rails.root.join('Frontend', 'features', 'support', 'test_images', 'fail.txt')
    attach_file(file_input_id, invalid_file_path) # Replace with the path to an invalid file format
  end
end

When('I choose a file of the wrong file format') do
  # This step assumes you attach a file of the wrong format in the previous step
end

Then('I should see a pop up warning that says {string}') do
  alert = page.driver.browser.switch_to.alert
  expect(alert.text).to eq("Invalid file type! Please upload a PDF, PNG, or JPG document.")
  alert.accept
end

Then('Then I should not be able to click on the "Next" button') do

end
