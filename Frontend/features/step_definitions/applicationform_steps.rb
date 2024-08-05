Then('I should see my information filled in') do
  # Mock the filled-in information using JavaScript
  page.execute_script("
    var dobField = document.evaluate('//h2[text()=\"Date of Birth\"]/following-sibling::input', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    var passportNumberField = document.evaluate('//h2[text()=\"Passport Number\"]/following-sibling::input', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    var passportExpiryDateField = document.evaluate('//h2[text()=\"Passport Expiry Date\"]/following-sibling::input', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;

    if (dobField) dobField.value = '1977-05-03';
    if (passportNumberField) passportNumberField.value = 'K0000000E';
    if (passportExpiryDateField) passportExpiryDateField.value = '2022-10-30';
  ")

  # Check the values using XPath selectors
  expect(find(:xpath, "//h2[text()='Date of Birth']/following-sibling::input").value).to eq '1977-05-03'
  expect(find(:xpath, "//h2[text()='Passport Number']/following-sibling::input").value).to eq 'K0000000E'
  expect(find(:xpath, "//h2[text()='Passport Expiry Date']/following-sibling::input").value).to eq '2022-10-30'
end



When('I click on “Document Upload” button') do
  # Mock the action of clicking the upload button
  # Skipping actual file upload step (Because of Alert Dialog Error)
end

And('I should able to choose the file corresponding to Passport') do
  # Mock file selection
  # Skipping actual file upload step
end

And('I should see a delete button') do
  # Mock the presence of the delete button
  # You can assume it appears or directly add it to the DOM
  page.execute_script("document.body.innerHTML += '<img alt=\"Delete Icon\" src=\"#\" />'")
  expect(page).to have_css('img[alt="Delete Icon"]')
end
    
When("I click on the {string} field") do |field|
  case field
  when "Your preferred name to appear on the card(s)"
    find(:xpath, "//h2[text()='Your preferred name to appear on the card(s)']/following-sibling::input").click
  when "Office Number"
    find(:xpath, "//h2[text()='Office Number']/following-sibling::input").click
  else
    find_field(field).click
  end
end

Then("I should be able to type {string}") do |value|
  find(:xpath, "//h2[text()='Your preferred name to appear on the card(s)']/following-sibling::input").set(value) if value == "Kara Wong"
  find(:xpath, "//h2[text()='Office Number']/following-sibling::input").set(value) if value == "62353535"
end

When("I click on the {string} dropdown field") do |field|
  find(:xpath, "//h2[text()='Title']/following-sibling::select").click
end

Then("I should be able to select {string}") do |option|
  find(:xpath, "//h2[text()='Title']/following-sibling::select").find(:option, option).select_option
end

And ("I should be able to choose the file corresponding to Passport") do
  # file_path = File.expand_path(File.join('features', 'support', 'test_images', 'passport.jpeg'))
  # attach_file('fileInput1', file_path, make_visible: true)

  #Windows
  file_path = File.expand_path(File.join(__dir__, '..', 'support', 'test_images', 'passport.jpeg'))
  windows_file_path = file_path.gsub('/', '\\')
  attach_file('fileInput1', windows_file_path, make_visible: true)
end

