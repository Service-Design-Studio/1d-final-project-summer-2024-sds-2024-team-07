Given('that I am on the application checklist page') do
  visit pages_applicationchecklist_path
end

When('I click onto the {string} section') do |section|
  @current_section = section
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
  @current_card_type = card_type
  case card_type
  when "Supplementary Credit Card"
    expect(page).to have_content('Eligibility')
    expect(page).to have_content('How to Apply')
  when "DBS Live Fresh Student Card"
    expect(page).to have_content('NRIC')
    expect(page).to have_content('Student Matriculation Card')
  when "Principal Credit Card"
    expect(page).to have_content('Identification Document')
    expect(page).to have_content('Financial Document')
  else
    raise "Card type not recognized: #{card_type}"
  end
end

Then('I should be able to click onto {string}') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Identification Document"
      find('div#identification_document').click
    when "Financial Document"
      find('div#financial_document').click
    when "Income Tax Notice of Assessment"
      find('div#income_tax_notice_of_assessment').click
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

And('I should see what {string} refers to') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Identification Document"
      expect(page).to have_content('An identification document is...')
    when "Financial Document"
      expect(page).to have_content('A financial document is...')
    when "Income Tax Notice of Assessment"
      expect(page).to have_content('An Income Tax Notice of Assessment is...')
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

And('I should see an image corresponding to an {string}') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Identification Document"
      expect(page).to have_css('img.identification_document')
    when "Income Tax Notice of Assessment"
      expect(page).to have_css('img.income_tax_notice_of_assessment')
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

And('I should see a gallery of images corresponding to {string}') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Financial Document"
      expect(page).to have_css('div.gallery.financial_document')
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

Then('I should be able to click onto the {string} button') do |button|
  if @current_card_type == "Principal Credit Card"
    case button
    when "Next"
      find('button.next').click
    when "Prev"
      find('button.prev').click
    else
      raise "Button not recognized: #{button}"
    end
  end
end

And('I should see other images corresponding to {string}') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Financial Document"
      expect(page).to have_css('div.gallery.financial_document img')
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

And('I should see the previous image corresponding to {string}') do |document_type|
  if @current_card_type == "Principal Credit Card"
    case document_type
    when "Financial Document"
      expect(page).to have_css('div.gallery.financial_document img')
    else
      raise "Document type not recognized: #{document_type}"
    end
  end
end

Then('I should be able to click onto the close icon') do
  find('span.close').click
end

And('I should be returned to the application checklist page') do
  expect(page).to have_current_path('/pages/applicationchecklist')
end
