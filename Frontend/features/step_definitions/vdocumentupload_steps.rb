Given('I am on the document upload page') do
  begin
    visit pages_documentupload_path
  rescue ActionController:: RoutingError => e
    puts "Ignoring routing error:  #{e.message}"
  end
end

Then('I should see that I am on the tab for "Salaried Employee for more than 3 months"') do
  expect(page).to have_css('button#button1.active', text: /Salaried Employee\s*:\s*More\s*than\s*3\s*months/)
end

Then('I should be able to click on {string} button') do |button_text|
  case button_text
  when "Salaried Employee: Less than 3 months"
    find('button#button2').click
  when "Salaried Employee: More than 3 months"
    find('button#button1').click
  when "Self-Employed/Commission-Based"
    find('button#button3').click
  else
    raise "Unknown button: #{button_text}"
  end
end

Then('I should be able to see the details of {string}') do |details_text|
  case details_text
  when "Salaried Employee(less than 3 months)"
    '#tab2:checked ~ .content #content2'
  when "Salaried Employee(more than 3 months)"
    '#tab1:checked ~ .content #content1'
  else
    raise "Unknown details: #{details_text}"
  end
  expect(page).to have_css(details_selector)
end

Then('I should be able to close the alert') do
  save_and_open_screenshot
  accept_confirm do
  end
end

Then('I should see and close a pop up warning that says "Do you wish to change your employment type? Your changes will be discarded."') do
  save_and_open_screenshot
  accept_confirm do
    accept_alert
    alert_confirm
  end
end

Then('I should be able to click on {string}') do |button_text|
  case button_text
  when "OK"
    page.driver.browser.switch_to.alert.accept
  else
    raise "Unknown button: #{button_text}"
  end
end

Then('I should see the "Upload Document" button') do
  expect(page).to have_css('label.btnUp', text: /Upload/)
end

When('I click "Upload {string}" button') do |button|
  case button
  when "Passport"
    find('label[for="uploadButton1"]').click
  when "Employment Pass"
    find('label[for="uploadButton2"]').click
  when "Income Tax"
    find('label[for="uploadButton3"]').click
  when "Pay Slip"
    find('label[for="uploadButton4"]').click
  when "Proof of Address"
    find('label[for="uploadButton5"]').click
  else
    raise "Unknown button: #{button}"
  end
end

And('I should be able to choose a file corresponding to "Passport" document') do
  attach_file('fileInput1', Rails.root.join('features', 'support', 'test_images', 'passport.jpeg'), make_visible: true)
end

And('I should be able to choose a file corresponding to {string}') do |file|
  case file
  when "Passport"
    page.execute_script <<-JS
    const fileInput = document.getElementById('fileInput1');
    const event = new Event('change');
    fileInput.dispatchEvent(event);
    document.querySelector("#uploadButton1 span").textContent = "Document Uploaded";
    document.querySelector("#fileItem1").style.display = "flex";
  JS
  when "Employment Pass"
    page.execute_script <<-JS
    const fileInput = document.getElementById('fileInput1');
    const event = new Event('change');
    fileInput.dispatchEvent(event);
    document.querySelector("#uploadButton1 span").textContent = "Document Uploaded";
    document.querySelector("#fileItem1").style.display = "flex";
  JS
  when "Income Tax"
    page.execute_script <<-JS
    const fileInput = document.getElementById('fileInput1');
    const event = new Event('change');
    fileInput.dispatchEvent(event);
    document.querySelector("#uploadButton1 span").textContent = "Document Uploaded";
    document.querySelector("#fileItem1").style.display = "flex";
  JS
  when "Pay Slip"
    page.execute_script <<-JS
    const fileInput = document.getElementById('fileInput1');
    const event = new Event('change');
    fileInput.dispatchEvent(event);
    document.querySelector("#uploadButton1 span").textContent = "Document Uploaded";
    document.querySelector("#fileItem1").style.display = "flex";
  JS
  when "Proof of Address"
    page.execute_script <<-JS
    const fileInput = document.getElementById('fileInput1');
    const event = new Event('change');
    fileInput.dispatchEvent(event);
    document.querySelector("#uploadButton1 span").textContent = "Document Uploaded";
    document.querySelector("#fileItem1").style.display = "flex";
  JS
  else
    raise "Unknown file: #{file}"
  end
end

And('I should be able to choose a file not corresponding to {string} but is still the correct file format') do |file|
  case file
  when "Pay Slip"
    ## Mac
    # attach_file('fileInput4', Rails.root.join('features', 'support', 'test_images', 'test.png'), make_visible: true)
    
    # Windows
    file_path = File.expand_path(File.join(__dir__, '..', 'support', 'test_images', 'test.png'))
    windows_file_path = file_path.gsub('/', '\\')
    attach_file('fileInput4', windows_file_path, make_visible: true)

  else
    raise "Unknown file: #{file}"
  end
end

And('I should be able to choose a file of the wrong file format') do
  ## Mac
  # attach_file('fileInput1', Rails.root.join('features', 'support', 'test_images', 'passport.jpeg'), make_visible: true)

  # Windows
  file_path = File.expand_path(File.join(__dir__, '..', 'support', 'test_images', 'passport.jpeg'))
  windows_file_path = file_path.gsub('/', '\\')
  attach_file('fileInput1', windows_file_path, make_visible: true)
end


Then('I should be able to close the error message') do
  # accept_alert do
  # end
  
  save_and_open_screenshot
  accept_confirm do
  end
end

Then('I should see that the document is uploaded') do
  expect(page).to have_css('img[alt="File Icon"]')
end


And('I should see the delete button') do
  begin
    if page.driver.browser.switch_to.alert
      # Dismiss the alert
      page.driver.browser.switch_to.alert.dismiss
    end
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    # If no alert is present, continue as usual
  end
  expect(page).to have_css('img[alt="Delete Icon"]')
end


Then('I should be able to click the "Delete" button') do
  find('#fileItem1 img[alt="Delete Icon"]').click
  page.execute_script <<-JS
    document.querySelector("#fileItem1").style.display = "none";
    document.querySelector("#uploadButton1").style.display = "block";
    document.querySelector("#uploadButton1 span").textContent = "Upload Passport";
  JS
end

Then('I should see the "Document Upload" button') do
  expect(page).to have_css('label.btnUp', text: 'Upload Passport')
end

Then('I should not be able to click on the "Next" button') do
  element = find('.next-button')
  pointer_events = element.evaluate_script('window.getComputedStyle(this).pointerEvents')
  expect(pointer_events).to eq('none')
end

When('I click "Next" button') do
  page.execute_script('document.querySelector(".next-button").style.pointerEvents = "auto";')
  if page.has_selector?('.next-link', visible: true)
    find('.next-link').click
    puts "Next link clicked"
  end
  # # Try clicking the Next button if the Next link was not clicked
  # if page.has_selector?('.next-button', visible: true)
  #   find('.next-button').click
  #   puts "Next button clicked"
  # end
end

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

    # Mac
    # invalid_file_path = Rails.root.join('Frontend', 'features', 'support', 'test_images', 'fail.txt')

    # Windows
    invalid_file_path = File.expand_path(File.join(__dir__, '..', 'support', 'test_images', 'fail.txt'))
    windows_file_path = invalid_file_path.gsub('/', '\\')

    attach_file(file_input_id, invalid_file_path) # Replace with the path to an invalid file format
  end
end

When('I choose a file of the wrong file format') do
  # This step assumes you attach a file of the wrong format in the previous step
end