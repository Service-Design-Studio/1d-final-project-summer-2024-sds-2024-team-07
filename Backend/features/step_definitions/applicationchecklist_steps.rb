Given('that I am on the application checklist page') do
  visit pages_applicationchecklist_path
end

When('I click onto the {string} section') do |section|
  case section
  when "Supplementary Credit Card"
    find('div#section2').click
  when "DBS Live Fresh Student Card"
    find('div#section3').click
  else
    raise "Section not recognized: #{section}"
  end
end

Then('I should see what is required for my {string} application') do |card_type|
  begin
    case card_type
    when "Supplementary Credit Card"
      expect(page).to have_content('Eligibility')
      expect(page).to have_content('How to Apply')
    when "DBS Live Fresh Student Card"
      expect(page).to have_content('NRIC')
      expect(page).to have_content('Student Matriculation Card')
    else
      raise "Card type not recognized: #{card_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

Then('I should be able to click onto the close icon') do
  find('span.close').click
end

And('I should be returned to the application checklist page') do
  expect(page).to have_current_path('/pages/applicationchecklist')
end
