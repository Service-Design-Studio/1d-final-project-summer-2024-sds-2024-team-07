Given('that I am on the application checklist page') do
  visit pages_applicationchecklist_path
end

When('I click onto the {string} section') do |section|
  case section
  when "Principal Credit Card"
    find('div#section1').click
  when "Supplementary Credit Card"
    find('div#section2').click
  when "DBS Live Fresh Student Card"
    find('div#section3').click
  else
    raise "Section not recognized: #{section}"
  end
end

When('I click onto {string}') do |document_type|
  begin
    case document_type
    when "Identification Document"
      find('button.accordion-header', text: 'Identification Document').click
    when "Financial Document"
      find('button.accordion-header', text: 'Financial Document').click
    when "Income Tax Notice of Assessment"
      find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    else
      raise "Unknown tab: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

Then('I should see what is required for my {string} application') do |card_type|
  begin
    case card_type
    when "Principal Credit Card"
      expect(page).to have_content('Identification Document')
      expect(page).to have_content('Financial Document')
      expect(page).to have_content('Income Tax Notice of Assessment')
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

Then('I should be able to see what {string} refers to') do |document_type|
  case document_type
  when "Identification Document"
    expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
  when "Financial Document"
    expect(page).to have_content("Submission of either documents are acceptable:")
    expect(page).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
    expect(page).to have_content("Latest 12 months’ CPF contribution history statement")
    expect(page).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
  when "Income Tax Notice of Assessment"
    expect(page).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
  else
    raise "Unknown tab: #{document_type}"
  end
end

Then('I should no longer see the section under {string}') do |document_type|
  case document_type
  when "Identification Document"
    expect(page).to have_no_content('NRIC (front & back) for Singaporean/Permanent Residents')
  when "Financial Document"
    expect(page).to have_no_content("Submission of either documents are acceptable:")
    expect(page).to have_no_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
    expect(page).to have_no_content("Latest 12 months’ CPF contribution history statement")
    expect(page).to have_no_content("Latest 3 months’ salary crediting bank statements in SGD")
  when "Income Tax Notice of Assessment"
    expect(page).to have_no_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
  else
    raise "Unknown tab: #{document_type}"
  end
end

And('I should see what {string} refers to') do |document_type|
  case document_type
  when "Identification Document"
    expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
  when "Financial Document"
    expect(page).to have_content("Submission of either documents are acceptable:")
    expect(page).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
    expect(page).to have_content("Latest 12 months’ CPF contribution history statement")
    expect(page).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
  when "Income Tax Notice of Assessment"
    expect(page).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
  else
    raise "Unknown tab: #{document_type}"
  end
end

And('I should be returned to the application checklist page') do
  expect(page).to have_current_path('/pages/applicationchecklist')
end

And('I have clicked onto the {string} section') do |section|
  case section
  when "Principal Credit Card"
    find('div#section1').click
  when "Supplementary Credit Card"
    find('div#section2').click
  when "DBS Live Fresh Student Card"
    find('div#section3').click
  else
    raise "Section not recognized: #{section}"
  end
end
