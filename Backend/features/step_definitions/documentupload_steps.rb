  Given('I am a salaried employee of more than 3 months') do
    
  end
  
  When('I want to find the documents I\'m required to upload') do
    
  end
  
  Then('I should be able to see 3 different buttons for the different employment status') do
    expect(page).to have_button('Salaried Employer A: More than 3 Months')
    expect(page).to have_button('Salaried Employer B: Less than 3 months')
    expect(page).to have_button('Self-Employed/Commision-Based')
  end
  
  Then('I should be able to click onto the Salaried Employee A button') do
    find_button('Salaried Employer A: More than 3 Months').click
  end
  
  When('I click on the Salaried Employee A button') do
    click_button('Salaried Employer A: More than 3 Months')
  end
  
  Then('I should be able to see 5 documents: Passport, Employment Pass, Income Tax, PaySlip and Proof of Address') do
    expect(page).to have_content('Valid Passport')
    expect(page).to have_content('Valid Employment Pass')
    expect(page).to have_content('Income Tax')
    expect(page).to have_content('Pay Slip')
    expect(page).to have_content('Proof of Singapore Address')
  end
  
  Then('I should see the sample document and document guidelines under the document names') do
    expect(page).to have_content('Sample Document')
    expect(page).to have_content('Document Guidelines')
  end
  
  Then('I should see those same documents on the sidebar under Documents') do
    expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Valid Passport')
    expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Valid Employment Pass')
    expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Income Tax')
    expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Pay Slip')
    expect(page).to have_css('.sidebar .nav-links .iocn-link', text: 'Proof of Singapore Address')
  end
  
  Given('I am a salaried employee of less than 3 months') do
    # This step is informational; no specific action needed
  end
  
  Then('I should be able to click onto the Salaried Employee B button') do
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
  
  Given('Commissioned-Based Employee/Self-Employed') do
    # This step is informational; no specific action needed
  end
  
  Then('I should be able to click onto the Commissioned-Based Employee button') do
    find_button('Self-Employed/Commision-Based').click
  end
  
  When('I click on the Commissioned-Based Employee button') do
    click_button('Self-Employed/Commision-Based')
  end
  
  Then('I should be able to see 4 documents: Passport, Employment Pass, Income Tax and Proof of Address') do
    expect(page).to have_content('Valid Passport')
    expect(page).to have_content('Valid Employment Pass')
    expect(page).to have_content('Income Tax')
    expect(page).to have_content('Proof of Singapore Address')
  end
  
  Given('that I click on the Upload Document Button') do
    find_button('Upload Document').click
  end
  
  Given('the file window pops up to prompt me to upload the document') do
    # This step is informational; no specific action needed
  end
  
  When('I click on the document that I want to upload') do
    attach_file('document_upload', Rails.root.join('spec/fixtures/files/sample_document.pdf'))
  end
  
  Then('the next tab should automatically open') do
    # Verify that the next tab is opened
    expect(page).to have_css('input[type="radio"]:checked + label', text: 'Valid Employment Pass')
  end
  
  Then('I should see the next document to upload') do
    expect(page).to have_content('Valid Employment Pass')
  end
  
  Then('I should see the respective sample document and guidelines') do
    expect(page).to have_content('Sample Document')
    expect(page).to have_content('Document Guidelines')
  end
  