require 'rails_helper'

RSpec.feature "ApplicationChecklist", type: :feature do
  scenario "Entering the page and viewing different application options" do
    visit pages_apply_path

    expect(page).to have_content('A SingPass Account')
    expect(page).to have_content('Use MyInfo data via SingPass to complete your applicationinstantly.')
    expect(page).to have_content('Apply with SingPass')
    expect(page).to have_content('DBS digibank Online')
    expect(page).to have_content('For salary crediting customers, complete your application fussfree.')
    expect(page).to have_content('Apply with digibank')
    expect(page).to have_content('Others and foreigners')
    expect(page).to have_content("Don't have either Singpass ordigibank account.")
    expect(page).to have_content('Document Upload')
  end
  scenario "Visiting application checklist page via apply page" do
    visit pages_apply_path
    find('a', text: 'application checklist').click
    expect(page).to have_current_path('/pages/applicationchecklist')
  end
  scenario "Beginning application via apply page" do
    visit pages_apply_path
    find('button.btn3', text: 'Document Upload').click
    expect(page).to have_current_path('/pages/documentupload')
  end
end
