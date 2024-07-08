Given('that I am on the document upload page') do
  visit upload_documents_path
end

When('I click on the Salaried Employer A: More than 3 Months button') do
  find('#button1').click
end

When('I click on the Salaried Employer B: Less than 3 months button') do
  find('#button2').click
end

When('I click on the Self-Employed/Commision-Based button') do
  find('#button3').click
end

Then('I should see all tabs for Salaried Employer A: More than 3 Months') do
  expect(page).to have_css('#tab1', visible: true)
  expect(page).to have_css('#tab2', visible: true)
  expect(page).to have_css('#tab3', visible: true)
  expect(page).to have_css('#tab4', visible: true)
  expect(page).to have_css('#tab5', visible: true)
end

Then('I should see tabs for Salaried Employer B: Less than 3 months') do
  expect(page).to have_css('#tab1', visible: true)
  expect(page).to have_css('#tab2', visible: true)
  expect(page).to have_css('#tab4', visible: true)
  expect(page).to have_css('#tab5', visible: true)
end

Then('I should see tabs for Self-Employed/Commision-Based') do
  expect(page).to have_css('#tab1', visible: true)
  expect(page).to have_css('#tab2', visible: true)
  expect(page).to have_css('#tab3', visible: true)
  expect(page).to have_css('#tab5', visible: true)
end

Then('I should see the next button') do
  expect(page).to have_css('a', text: 'Next', visible: true)
end

When('I click on the next button') do
  find('a', text: 'Next').click
end

Then('I should be brought to the application form page') do
  expect(current_path).to eq(pages_applicationform_path)
end

Then('I should see the Valid Passport tab') do
  expect(page).to have_css('label[for="tab1"]', visible: true)
end

Then('I should see the Valid Employment Pass tab') do
  expect(page).to have_css('label[for="tab2"]', visible: true)
end

Then('I should see the Income Tax tab') do
  expect(page).to have_css('label[for="tab3"]', visible: true)
end

Then('I should see the Pay Slip tab') do
  expect(page).to have_css('label[for="tab4"]', visible: true)
end

Then('I should see the Proof of Singapore Address tab') do
  expect(page).to have_css('label[for="tab5"]', visible: true)
end


##Sad Path
Given('that I am on the document upload page') do
  visit upload_documents_path
end

When('I click on the Salaried Employer A: More than 3 Months button but it fails to load') do
  allow_any_instance_of(DocumentsController).to receive(:show).and_raise(StandardError, 'Failed to load documents')
end

Then('I should see an error message for Salaried Employer A') do
  expect(page).to have_content('Failed to load documents')
end

When('I click on the Salaried Employer B: Less than 3 months button but it fails to load') do
  allow_any_instance_of(DocumentsController).to receive(:show).and_raise(StandardError, 'Failed to load documents')
end

Then('I should see an error message for Salaried Employer B') do
  expect(page).to have_content('Failed to load documents')
end

When('I click on the Self-Employed/Commision-Based button but it fails to load') do
  allow_any_instance_of(DocumentsController).to receive(:show).and_raise(StandardError, 'Failed to load documents')
end

Then('I should see an error message for Self-Employed/Commision-Based') do
  expect(page).to have_content('Failed to load documents')
end

When('I click on the next button but the application form fails to load') do
  find('a', text: 'Next').click
  allow_any_instance_of(ApplicationFormController).to receive(:show).and_raise(StandardError, 'Failed to load application form')
end

Then('I should see an error message for the application form') do
  expect(page).to have_content('Failed to load application form')
end

Then('I should not be brought to the application form page') do
  expect(current_path).not_to eq(pages_applicationform_path)
end

When('I try to load a tab that does not exist') do
  find('label[for="tab6"]').click rescue StandardError
end

Then('I should see an error message for the invalid tab') do
  expect(page).to have_content('Tab not found')
end
