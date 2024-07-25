require 'rails_helper'

RSpec.feature "ApplicationChecklist", type: :feature do
  scenario "Viewing documents required for Singaporean salaried employee (more than 3 months)" do
    visit pages_applicationchecklist_path

    find('div#section1').click # Click on "Principal Credit Card" section

    within('#label1.tab-content') do
      expect(page).to have_content('Identification Document')
      expect(page).to have_css("img[src*='Nric-c859373acea659332f601402c8738708f67598479ea4e4ebf6df29bc47252af8.png']", visible: true)
    end

    find('button.accordion-header', text: 'Financial Document').click

    within('#label2.tab-content') do
      expect(page).to have_no_content('Identification Document')
      expect(page).to have_content('Financial Document')
      expect(page).to have_css("img[src*='income-slip-a9663ea0923f09a528b4e6c212a252fc7cd358888d467a5c9061a1ea876570b7.png']", visible: true)
    end

    find('.next').click
    within('#label2.tab-content') do
      expect(page).to have_css("img[src*='cpf-contribution-history-c4e4d31275c54d803677fccd98b882bd98a7a29fb472d7ac88ee7612f9cdc2ea.jpg']", visible: true)
    end

    find('.prev').click
    within('#label2.tab-content') do
      expect(page).to have_css("img[src*='income-slip-a9663ea0923f09a528b4e6c212a252fc7cd358888d467a5c9061a1ea876570b7.png']", visible: true)
    end

    find('button.accordion-header', text: 'Income Tax Notice of Assessment').click
    within('#label3.tab-content') do
      expect(page).to have_no_content('Financial Document')
      expect(page).to have_content('Income Tax Notice of Assessment')
      expect(page).to have_css("img[src*='tax-assesment-dda2ef0e856cecb0f63c77f0afec41287953466de0bf7cba351a45850c75a133.png']", visible: true)
    end

    find('span.close').click
    expect(page).to have_current_path(pages_applicationchecklist_path)
  end

  # Add other scenarios similarly, scoping within specific elements as needed.

end
