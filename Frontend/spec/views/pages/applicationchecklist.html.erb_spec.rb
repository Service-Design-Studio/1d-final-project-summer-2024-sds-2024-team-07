require 'rails_helper'

RSpec.feature "ApplicationChecklist", type: :feature do
  scenario "Viewing documents required for Singaporean salaried employee (more than 3 months)" do
    visit pages_applicationchecklist_path

    find('div#section1').click # Click on "Principal Credit Card" section

    within('#label1.tab-content') do
      expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
      expect(page).to have_css("img.main-image", visible: true)
    end

    find('button.accordion-header', text: 'Financial Document').click
    within('#label1.tab-content') do
      expect(page).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
      expect(page).to have_content("Latest 12 months’ CPF Contribution History Statement")
      expect(page).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
      expect(page).to have_css("img", visible: true)
    end

    find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    within('#label1.tab-content') do
      expect(page).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
      expect(page).to have_css("img.main-image", visible: true)
    end
  end
  scenario "Viewing documents required for Singaporean salaried employee (less than 3 months)" do
    visit pages_applicationchecklist_path

    find('button', text: 'Salaried Employee (less than 3 months)').click # Click on "Principal Credit Card" section

    within('#label1.tab-content') do
      expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
      expect(page).to have_css("img.main-image", visible: true)
    end

    find('button.accordion-header', text: 'Financial Document').click
    within('#label1.tab-content') do
      expect(page).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
      expect(page).to have_content("Latest 12 months’ CPF Contribution History Statement")
      expect(page).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
      expect(page).to have_css("img", visible: true)
    end
  end
  scenario "Viewing documents required for Singaporean Variable/Commission-based Employees or Self-Employed" do
    visit pages_applicationchecklist_path

    find('button', text: 'Variable/Commission-based Employees or Self-Employed').click # Click on "Principal Credit Card" section

    within('#label1.tab-content') do
      expect(page).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
      expect(page).to have_css("img.main-image", visible: true)
    end

    find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    within('#label1.tab-content') do
      expect(page).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
      expect(page).to have_css("img.main-image", visible: true)
    end
  end
  scenario "Returning to apply page via application checklist page" do
    visit pages_applicationchecklist_path
    find('a', text: 'application page').click
    expect(page).to have_current_path('/pages/apply')
  end
end
# #unit testing
# RSpec.describe 'pages/applicationchecklist.html.erb', type: :view do
#   before do
#     assign(:application_type, 'Salaried Employee (more than 3 months)')
#     render
#   end

#   it 'displays the NRIC section correctly' do
#     expect(rendered).to have_selector('div#section1')
#     expect(rendered).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
#     expect(rendered).to have_css("img.main-image")
#   end

#   it 'displays the Financial Document section correctly' do
#     expect(rendered).to have_selector('button.accordion-header', text: 'Financial Document')
#     expect(rendered).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
#     expect(rendered).to have_content("Latest 12 months’ CPF Contribution History Statement")
#     expect(rendered).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
#     expect(rendered).to have_css("img")
#   end

#   it 'displays the Income Tax Notice of Assessment section correctly' do
#     expect(rendered).to have_selector('button.accordion-header', text: 'Income Tax Notice of Assessment')
#     expect(rendered).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
#     expect(rendered).to have_css("img.main-image")
#   end

#   context 'when application type is Salaried Employee (less than 3 months)' do
#     before do
#       assign(:application_type, 'Salaried Employee (less than 3 months)')
#       render
#     end

#     it 'displays the NRIC section correctly' do
#       expect(rendered).to have_selector('div#section1')
#       expect(rendered).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
#       expect(rendered).to have_css("img.main-image")
#     end

#     it 'displays the Financial Document section correctly' do
#       expect(rendered).to have_selector('button.accordion-header', text: 'Financial Document')
#       expect(rendered).to have_content("Latest 3 months’ computerised payslip in SGD is preferred; else minimally Latest 1 month’s computerised payslip")
#       expect(rendered).to have_content("Latest 12 months’ CPF Contribution History Statement")
#       expect(rendered).to have_content("Latest 3 months’ salary crediting bank statements in SGD")
#       expect(rendered).to have_css("img")
#     end
#   end

#   context 'when application type is Variable/Commission-based Employees or Self-Employed' do
#     before do
#       assign(:application_type, 'Variable/Commission-based Employees or Self-Employed')
#       render
#     end

#     it 'displays the NRIC section correctly' do
#       expect(rendered).to have_selector('div#section1')
#       expect(rendered).to have_content('NRIC (front & back) for Singaporean/Permanent Residents')
#       expect(rendered).to have_css("img.main-image")
#     end

#     it 'displays the Income Tax Notice of Assessment section correctly' do
#       expect(rendered).to have_selector('button.accordion-header', text: 'Income Tax Notice of Assessment')
#       expect(rendered).to have_content('Latest 2 years of Income Tax Notice of Assessment in SGD is preferred; else minimally latest 1 year of Income Tax Notice of Assessment')
#       expect(rendered).to have_css("img.main-image")
#     end
#   end
# end
