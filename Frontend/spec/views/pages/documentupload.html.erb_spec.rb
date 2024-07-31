require 'rails_helper'

#Unit Testing
RSpec.describe "DocumentUpload", type: :view do
  before do
    render template: 'pages/documentupload'
  end

  describe "Viewing document upload options" do
    it "displays buttons for different employee types" do
      expect(rendered).to have_button('Salaried Employee : More than 3 Months')
      expect(rendered).to have_button('Salaried Employee : Less than 3 months')
      expect(rendered).to have_button('Self-Employed/Commission-Based')
    end

    it "displays content for documents" do
      expect(rendered).to have_content('Passport')
      expect(rendered).to have_content('Employment Pass')
      expect(rendered).to have_content('Income Tax')
      expect(rendered).to have_content('Pay Slip')
      expect(rendered).to have_content('Proof of Address')
    end
  end

  describe "Switching between different employee types" do
    it "shows correct tabs for 'Salaried Employee : More than 3 Months'" do
      render template: 'pages/documentupload', locals: { employee_type: 1 }
      expect(rendered).to have_selector('label[for="tab1"]', visible: true)
      expect(rendered).to have_selector('label[for="tab2"]', visible: true)
      expect(rendered).to have_selector('label[for="tab3"]', visible: true)
      expect(rendered).to have_selector('label[for="tab4"]', visible: true)
      expect(rendered).to have_selector('label[for="tab5"]', visible: true)
    end

    it "shows correct tabs for 'Salaried Employee : Less than 3 months'" do
      render template: 'pages/documentupload', locals: { employee_type: 2 }
      expect(rendered).to have_selector('label[for="tab1"]', visible: true)
      expect(rendered).to have_selector('label[for="tab2"]', visible: true)
      expect(rendered).to have_selector('label[for="tab4"]', visible: true)
      expect(rendered).to have_selector('label[for="tab5"]', visible: true)
      expect(rendered).to have_selector('label[for="tab3"]', visible: false)
    end

    it "shows correct tabs for 'Self-Employed/Commission-Based'" do
      render template: 'pages/documentupload', locals: { employee_type: 3 }
      expect(rendered).to have_selector('label[for="tab1"]', visible: true)
      expect(rendered).to have_selector('label[for="tab2"]', visible: true)
      expect(rendered).to have_selector('label[for="tab3"]', visible: true)
      expect(rendered).to have_selector('label[for="tab5"]', visible: true)
      expect(rendered).to have_selector('label[for="tab4"]', visible: false)
    end
  end
end


#Integration Testing
RSpec.feature "DocumentUpload Integration Test Cases", type: :feature do
  scenario "Entering the page and viewing document upload options" do
    visit pages_documentupload_path

    expect(page).to have_button('Salaried Employee : More than 3 Months')
    expect(page).to have_button('Salaried Employee : Less than 3 months')
    expect(page).to have_button('Self-Employed/Commission-Based')
    expect(page).to have_content('Passport')
    expect(page).to have_content('Employment Pass')
    expect(page).to have_content('Income Tax')
    expect(page).to have_content('Pay Slip')
    expect(page).to have_content('Proof of Address')
  end

  scenario "Switching between different employee types" do
    visit pages_documentupload_path

    find('button', text: 'Salaried Employee : More than 3 Months').click
    expect(page).to have_selector('label[for="tab1"]', visible: true)
    expect(page).to have_selector('label[for="tab2"]', visible: true)
    expect(page).to have_selector('label[for="tab3"]', visible: true)
    expect(page).to have_selector('label[for="tab4"]', visible: true)
    expect(page).to have_selector('label[for="tab5"]', visible: true)

    find('button', text: 'Salaried Employee : Less than 3 months').click
    expect(page).to have_selector('label[for="tab1"]', visible: true)
    expect(page).to have_selector('label[for="tab2"]', visible: true)
    expect(page).to have_selector('label[for="tab4"]', visible: true)
    expect(page).to have_selector('label[for="tab5"]', visible: true)
    expect(page).to have_selector('label[for="tab3"]', visible: false)

    find('button', text: 'Self-Employed/Commission-Based').click
    expect(page).to have_selector('label[for="tab1"]', visible: true)
    expect(page).to have_selector('label[for="tab2"]', visible: true)
    expect(page).to have_selector('label[for="tab3"]', visible: true)
    expect(page).to have_selector('label[for="tab5"]', visible: true)
    expect(page).to have_selector('label[for="tab4"]', visible: false)
  end



  scenario "Uploading and deleting files" do
    visit pages_documentupload_path

    find('#fileInput1', visible: false).set(Rails.root.join('spec/fixtures/files/passport.jpg'))

    expect(page).to have_css('#fileItem1 .file-name', visible: false)
    expect(page).to have_css('div#fileItem1', visible: false)
    expect(page).to have_css('label#uploadButton1', visible: false)

    find('#fileItem1 .delete-icon', visible: false).click
    expect(page).to have_css('div#fileItem1', visible: false)
    expect(page).to have_css('label#uploadButton1', visible: true)

    find('#fileInput2', visible: false).set(Rails.root.join('spec/fixtures/files/employment_pass.png'))

    expect(page).to have_css('#fileItem2 .file-name', visible: false)
    expect(page).to have_css('div#fileItem2', visible: false)
    expect(page).to have_css('label#uploadButton2', visible: false)

    find('#fileItem2 .delete-icon', visible: false).click
    expect(page).to have_css('div#fileItem2', visible: false)
    expect(page).to have_css('label#uploadButton2', visible: true)
  end


  scenario "Proceeding to the next step when all files are uploaded" do
    visit pages_documentupload_path

    # Ensure file inputs are visible and enabled
    find('#fileInput1', visible: false).set(Rails.root.join('spec/fixtures/files/passport.jpg'))
    find('#fileInput2', visible: false).set(Rails.root.join('spec/fixtures/files/employment_pass.png'))
    find('#fileInput3', visible: false).set(Rails.root.join('spec/fixtures/files/income_tax.png'))
    find('#fileInput4', visible: false).set(Rails.root.join('spec/fixtures/files/pay_slip.png'))
    find('#fileInput5', visible: false).set(Rails.root.join('spec/fixtures/files/proof_of_address.png'))

    expect(page).to have_link('Next', href: pages_applicationform_path)
    find('a', text: 'Next').click
    expect(page).to have_current_path(pages_applicationform_path)
  end
end
