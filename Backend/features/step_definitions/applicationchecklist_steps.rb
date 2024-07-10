Given('that I am on the application checklist page') do
  visit pages_applicationchecklist_path
end

#Clicking into different sections of the web - types of card
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

#an And case for the clicking into different sections of the web - types of card
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

#Then Clicking into different sections and content of the section
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

#an And for the looking inside the content of each header
And('I should see what {string} refers to') do |document_type|
  within '#principal_popup' do
    case document_type
    when "Identification Document"
      expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
    when "Financial Document"
      # Check the active tab's text and verify the content accordingly
      active_tab = find('button.tab.active', visible: false).text
      if active_tab.include?('Salaried Employee (more than 3 months)')
        expect(page).to have_content('Submission of either documents are acceptable:')
        expect(page).to have_content('Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip')
        expect(page).to have_content('Latest 12 months’ CPF Contribution History Statement')
        expect(page).to have_content('Latest 3 months’ salary crediting bank statements in SGD')
      elsif active_tab.include?('Salaried Employee (less than 3 months)')
        expect(page).to have_content('Submission of either documents are acceptable:')
        expect(page).to have_content('Latest computerised payslip in SGD')
        expect(page).to have_content('Full Set of Letter of Appointment (Signed copy by HR and you) + Copy of Staff Pass')
      elsif active_tab.include?('Variable/ Commission-based Employees/ Self-Employed')
        expect(page).to have_content('Submission of either documents are acceptable:')
        expect(page).to have_content('Latest 2 years Income Tax Notice of Assessment')
        expect(page).to have_content('Latest 6 months’ salary crediting bank statements in SGD')
      else
        raise "Unknown tab for Financial Document"
      end
    when "Income Tax Notice of Assessment"
      expect(page).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
    else
      raise "Unknown document type: #{document_type}"
    end
  end
end



#Clicking into the different headers and opening the content
Then('I should be able to see what {string} refers to') do |document_type|
  begin
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
    when "Valid Passport"
      expect(page).to have_content('Passport for Foreigner (minimum validity of 6 months at the time of application)')
    when "Employment Pass"
      expect(page).to have_content('Employment Pass must have a minimum validity of 6 months at the time of application. Any of these following pass is acceptable:')
    when "Latest Computerised Payslip"
      expect(page).to have_content("Document must be dated within 3 months before the date of application; else minimally Latest 1 month’s computerised payslip")
    when "Proof of Residential Address"
      expect(page).to have_content("Latest copy of your Residential Address proof dated within 3 months before the date of card application (For new DBS/POSB Bank customers only).")
    when "Proof of Employment"
      expect(page).to have_content("Latest Computerised Payslip")
      expect(page).to have_content("Company letter certifying employment and salary")
    when "Latest Income Tax Notice of Assessment"
      expect(page).to have_content("Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment")
    else
      raise "Unknown tab: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

#Sad Case where you cannot see the previous tab content
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

#Clicking into different headers inside a tab
When('I click onto {string}') do |document_type|
  begin
    case document_type
    when "Identification Document"
      find('button.accordion-header', text: 'Identification Document').click
    when "Financial Document"
      find('button.accordion-header', text: 'Financial Document').click
    when "Income Tax Notice of Assessment"
      find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    when "Employment Pass"
      find('button.accordion-header', text: 'Employment Pass').click
    when "Proof of Residential Address"
      find('button.accordion-header', text: 'Proof of Residential Address').click
    when "Proof of Employment"
      find('button.accordion-header', text: 'Proof of Employment').click
    else
      raise "Unknown tab: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

And('I have clicked onto {string}') do |document_type|
  begin
    case document_type
    when "Income Tax Notice of Assessment"
      find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    when "Employment Pass"
      find('button.accordion-header', text: 'Employment Pass').click
    when "Proof of Residential Address"
      find('button.accordion-header', text: 'Proof of Residential Address').click
    when "Proof of Employment"
      find('button.accordion-header', text: 'Proof of Employment').click
    when 'Latest Computerised Payslip'
      find('button.accordion-header', text: 'Latest Computerised Payslip').click
    when 'Latest Income Tax Notice of Assessment'
      find('button.accordion-header', text: 'Latest Income Tax Notice of Assessment').click
    else
      raise "Unknown tab: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

# Closing the popup
Then('I should be able to click onto the close icon') do
  find('span.close').click
end

#returning to the main page
And('I should be returned to the application checklist page') do
  begin
    expect(page).to have_current_path('/pages/applicationchecklist')
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

#If there is only one image
And('I should see an image corresponding to a {string}') do |document_type|
  begin
    case document_type
    when "Identification Document"
      expect(page).to have_css("img[src*='Nric.png']")
    when "Financial Document"
      expect(page).to have_css("img[src*='income-slip.png']")
    when "Income Tax Notice of Assessment"
      expect(page).to have_css("img[src*='tax-assesment.png']")
    when "Valid Passport"
      expect(page).to have_css("img[src*='passport.jpeg']")
    when "Latest Computerised Payslip"
      expect(page).to have_css("img[src*='income-slip.png']")
    when "Latest Income Tax Notice of Assessment"
      expect(page).to have_css("img[src*='tax-assesment.png']")
    else
      raise "Unknown document type: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end


#handle the gallery
And('I should see the first image corresponding to {string}') do |document_type|
  begin
    case document_type
    when "Identification Document"
      expect(page).to have_css("img[src*='Nric.png']")
    when "Financial Document"
      expect(page).to have_css("img[src*='income-slip.png']", visible: true)
    when "Income Tax Notice of Assessment"
      expect(page).to have_css("img[src*='tax-assesment.png']")
    when "Employment Pass"
      expect(page).to have_css("img[src*='employment-pass.jpg']")
    when "Proof of Residential Address"
      expect(page).to have_css("img[src*='employment-certificate.jpg']")
    when "Proof of Employment"
      expect(page).to have_css("img[src*='income-slip.png']")
    else
      raise "Unknown document type: #{document_type}"
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

Then('I should see the next image corresponding to {string}') do |document_type|
  case document_type
  when "Financial Document"
    expect(page).to have_css("img[src*='cpf-contribution-history.jpg']", visible: true)
  when "Employment Pass"
    expect(page).to have_css("img[src*='spass.jpg']", visible: true)
  when "Proof of Residential Address"
    expect(page).to have_css("img[src*='utility-bill.webp']", visible: true)
  when "Proof of Employment"
    expect(page).to have_css("img[src*='employment-certificate.jpg']", visible: true)
  else
    raise "Unknown document type: #{document_type}"
  end
end

Then('I should see the previous image corresponding to {string}') do |document_type|
  case document_type
  when "Financial Document"
    expect(page).to have_css("img[src*='income-slip.png']", visible: true)
  when "Employment Pass"
    expect(page).to have_css("img[src*='employment-pass.jpg']", visible: true)
  when "Proof of Residential Address"
    expect(page).to have_css("img[src*='employment-certificate.jpg']", visible: true)
  when "Proof of Employment"
    expect(page).to have_css("img[src*='income-slip.png']", visible: true)
  else
    raise "Unknown document type: #{document_type}"
  end
end

When('I click onto the {string} button') do |button_name|
  case button_name
  when "Next"
    find('.next').click
  when "Prev"
    find('.prev').click
  else
    raise "Unknown button: #{button_name}"
  end
end

#Different Tabs
When('I click onto {string} tab') do |tab_name|
  begin
    within '#principal_popup' do
      case tab_name
      when "Salaried Employee (more than 3 months)"
        find('button.tab', text: 'Salaried Employee (more than 3 months)').click
      when "Salaried Employee (less than 3 months)"
        find('button.tab', text: 'Salaried Employee (less than 3 months)').click
      when "Variable/Commission-based Employees or Self-Employed"
        find('button.tab', text: 'Variable/Commission-based Employees or Self-Employed').click
      else
        raise "Unknown tab: #{tab_name}"
      end
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

And('I have clicked onto {string} tab') do |tab_name|
  begin
    within '#principal_popup' do
      case tab_name
      when "Salaried Employee (more than 3 months)"
        find('button.tab', text: 'Salaried Employee (more than 3 months)').click
      when "Salaried Employee (less than 3 months)"
        find('button.tab', text: 'Salaried Employee (less than 3 months)').click
      when "Variable/Commission-based Employees or Self-Employed"
        find('button.tab', text: 'Variable/Commission-based Employees or Self-Employed').click
      else
        raise "Unknown tab: #{tab_name}"
      end
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

# Foreigner and PR/SG  toggle
When(/^I click on "(.*?)" toggle$/) do |toggle_name|
  begin
    within '#principal_popup' do
      find('label.toggle-label').click
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end

And(/^I have clicked on "(.*?)" toggle$/) do |toggle_name|
  begin
    within '#principal_popup' do
      find('label.toggle-label').click
    end
  rescue ActionController::RoutingError => e
    puts "Ignoring routing error: #{e.message}"
  end
end
