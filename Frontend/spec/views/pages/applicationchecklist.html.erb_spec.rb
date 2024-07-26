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
end
