Then("I should see my information filled in") do
    expect(find_field('date_of_birth').value).to eq '1977-05-03'
    expect(find_field('passport_number').value).to eq 'K0000000E'
    expect(find_field('passport_expiry_date').value).to eq '2022-10-30'
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
    attach_file('fileInput1', Rails.root.join('features', 'support', 'test_images', 'passport.jpeg'), make_visible: true)
  end