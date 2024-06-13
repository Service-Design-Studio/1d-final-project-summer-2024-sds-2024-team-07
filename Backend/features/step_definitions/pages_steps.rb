#Test One!
Given("I am on the card options page") do
    visit cardoptions_path
  end
  
  Then("I should see {string}") do |content|
    expect(page).to have_content(content)
  end
  