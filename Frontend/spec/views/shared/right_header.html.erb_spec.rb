require 'rails_helper'

#Unit Testing

RSpec.describe 'shared/_header', type: :view do
  include ApplicationHelper

  before do
    allow(view).to receive(:current_page?).and_return(false)
  end

  context 'when on the document upload page' do
    before do
      allow(view).to receive(:current_page?).with(pages_documentupload_path).and_return(true)
      render partial: 'shared/right_header'
    end 

    it 'displays the header content' do
      expect(rendered).to have_css('.custom-title', text: 'Credit Card Application')
    end

    it 'marks the "Upload Documents" step as active' do
      expect(rendered).to have_css('.custom-step.active .custom-step-label', text: 'Upload Documents')
    end

    it 'does not mark other steps as active' do
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Application Details')
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Verify Details')
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Create Pin')
    end
  end

  context 'when on the application form page' do
    before do
      allow(view).to receive(:current_page?).with(pages_applicationform_path).and_return(true)
      render partial: 'shared/right_header'
    end

    it 'marks the "Application Details" step as active' do
      expect(rendered).to have_css('.custom-step.active .custom-step-label', text: 'Application Details')
    end

    it 'does not mark other steps as active' do
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Upload Documents')
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Verify Details')
      expect(rendered).not_to have_css('.custom-step.active .custom-step-label', text: 'Create Pin')
    end
  end
end


#Integration Testings
RSpec.feature "Header Integration Test", type: :feature do
  scenario "Header should change colour based on which page I am on" do
    visit pages_documentupload_path

    expect(page).to have_content('Credit Card Application')
    expect(page).to have_content('Upload Documents')
    expect(page).to have_content('Application Details')
    expect(page).to have_content('Verify Details')
    expect(page).to have_content('Create Pin')

    within('div.custom-step.active') do
      expect(page).to have_content('1.')
      expect(page).to have_content('Upload Documents')
    end

    visit pages_applicationform_path
    expect(page).to have_content('Credit Card Application')
    expect(page).to have_content('Upload Documents')
    expect(page).to have_content('Application Details')
    expect(page).to have_content('Verify Details')
    expect(page).to have_content('Create Pin')

    within('div.custom-step.active') do
      expect(page).to have_content('2.')
      expect(page).to have_content('Application Details')
    end
  end
end
