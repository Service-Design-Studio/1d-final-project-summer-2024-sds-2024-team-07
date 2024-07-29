require 'rails_helper'

RSpec.feature "ApplicationChecklist", type: :feature do
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
