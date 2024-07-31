require 'rails_helper'

#Unit Testing
RSpec.describe 'Apply Page Unit Test Cases', type: :view do
  before do
    render template: 'pages/apply'
  end

  it 'displays the page title' do
    expect(rendered).to have_css('h1.page-title', text: 'You are applying for')
  end

  it 'displays the card image' do
    expect(rendered).to have_css('img[alt="Example Image"]')
  end

  it 'displays the card name' do
    expect(rendered).to have_css('div.new_card_name p', text: 'DBS yuu Visa card')
  end

  it 'displays the application method headers' do
    expect(rendered).to have_css('h2.left_header', text: 'I would like to apply using:')
  end

  it 'displays the SingPass option' do
    expect(rendered).to have_css('div.new_text_box h3', text: 'A SingPass Account')
    expect(rendered).to have_css('div.new_text_box p', text: /Use MyInfo data via SingPass to complete your application/)
  end

  it 'displays the digibank option' do
    expect(rendered).to have_css('div.new_text_box h3', text: 'DBS digibank Online')
    expect(rendered).to have_css('div.new_text_box p', text: /For salary crediting customers, complete your application fuss/)
  end

  it 'displays the "Others and foreigners" option' do
    expect(rendered).to have_css('div.new_text_box h3', text: 'Others and foreigners')
    expect(rendered).to have_css('div.new_text_box p', text: /Don't have either Singpass or/)
  end

  it 'displays the "Apply with SingPass" link' do
    expect(rendered).to have_link('Apply with SingPass')
  end

  it 'displays the "Apply with digibank" button' do
    expect(rendered).to have_css('button.btn2', text: 'Apply with digibank')
  end

  it 'displays the "Document Upload" button' do
    expect(rendered).to have_css('button.btn3', text: 'Document Upload')
  end

  it 'displays the link to the application checklist' do
    expect(rendered).to have_link('application checklist', href: pages_applicationchecklist_path)
  end
end

#Intergration Testing
RSpec.feature "Apply Page Integration Test", type: :feature do
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
