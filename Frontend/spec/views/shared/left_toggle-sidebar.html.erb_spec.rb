require 'rails_helper'
#Unit Testing
RSpec.describe "ToggleSidebar", type: :view do
  it "renders the logo" do
    render template: "pages/documentupload"
    expect(rendered).to have_css("div.logo-details img.logo-icon[alt='DBS']")
  end
end

RSpec.describe "ToggleSidebar", type: :view do
  before do
    render template: "pages/documentupload"
  end

  it "renders the Application Checklist link" do
    expect(rendered).to have_css("span.link_name", text: "Application Checklist")
  end

  it "renders the Documents link" do
    expect(rendered).to have_css("span.link_name", text: "1. Documents")
  end

  it "renders the Particulars link" do
    expect(rendered).to have_css("span.link_name", text: "2. Particulars")
  end
end

RSpec.describe "ToggleSidebar Tabs", type: :view do
  before do
    allow(view).to receive(:relevant_page?).with(pages_documentupload_path).and_return(true)
    allow(view).to receive(:relevant_page?).with(pages_applicationform_path).and_return(false)
  end
  it "renders the Documents sub-menu items with links" do
    render template: "shared/_left_toggle-sidebar"

    within('div.sidebar') do
      expect(rendered).to have_content('1. Documents')
      expect(rendered).to have_css('li#item-tab1 a[data-tab="tab1"]', text: 'Valid Passport')
      expect(rendered).to have_css('li#item-tab2 a[data-tab="tab2"]', text: 'Valid Employment Pass')
      expect(rendered).to have_css('li#item-tab3 a[data-tab="tab3"]', text: 'Income Tax')
      expect(rendered).to have_css('li#item-tab4 a[data-tab="tab4"]', text: 'Pay Slip')
      expect(rendered).to have_css('li#item-tab5 a[data-tab="tab5"]', text: 'Proof of Singapore Address')
    end
  end
end

#Integration Testing


# #Integration Testings
# RSpec.feature "ApplicationChecklist", type: :feature do
#   scenario "Viewing details of both pages" do
#     visit pages_documentupload_path

#     within('div.sidebar') do
#       expect(page).to have_content('1. Documents')
#       expect(page).to have_content('2. Particulars')
#       expect(page).to have_content('3. Verify Particulars')
#       expect(page).to have_content('4. Create Pin')
#     end

#     find('div.icon-link', text: '1. Documents').click

#     within('div.sidebar') do
#       expect(page).to have_content('Valid Passport')
#       expect(page).to have_content('Valid Employment Pass')
#       expect(page).to have_content('Income Tax')
#       expect(page).to have_content('Pay Slip')
#       expect(page).to have_content('Proof of Singapore Address')
#     end

#     find('div.icon-link', text: '2. Particulars').click

#     within('div.sidebar') do
#       expect(page).to have_content('Personal Information')
#       expect(page).to have_content('Name')
#       expect(page).to have_content('Date of Birth')
#       expect(page).to have_content('Gender')
#       expect(page).to have_content('Contact Information')
#       expect(page).to have_content('Mobile Number')
#       expect(page).to have_content('Email Address')
#       expect(page).to have_content('Home Number')
#       expect(page).to have_content('Office Number')
#       expect(page).to have_content('Passport Details')
#       expect(page).to have_content('Nationality')
#       expect(page).to have_content('Passport Number')
#       expect(page).to have_content('Passport Expiry Date')
#       expect(page).to have_content('Residential Details')
#       expect(page).to have_content('Residential Address')
#       expect(page).to have_content('Type of Residence')
#       expect(page).to have_content('Residential Status')
#       expect(page).to have_content('Number of years at this residence')
#       expect(page).to have_content('Professional Details')
#       expect(page).to have_content('Education Level')
#       expect(page).to have_content('Current Job Status')
#       expect(page).to have_content('Occupation')
#       expect(page).to have_content('Job Industry')
#       expect(page).to have_content('Company Name')
#       expect(page).to have_content('Length of Current Employment')
#       expect(page).to have_content('Current Job Status')
#       expect(page).to have_content('Current Office Address')
#     end

#     visit pages_applicationform_path

#     within('div.sidebar') do
#       expect(page).to have_content('1. Documents')
#       expect(page).to have_content('2. Particulars')
#       expect(page).to have_content('3. Verify Particulars')
#       expect(page).to have_content('4. Create Pin')
#     end

#     find('div.icon-link', text: '1. Documents').click

#     within('div.sidebar') do
#       expect(page).to have_content('Valid Passport')
#       expect(page).to have_content('Valid Employment Pass')
#       expect(page).to have_content('Income Tax')
#       expect(page).to have_content('Pay Slip')
#       expect(page).to have_content('Proof of Singapore Address')
#     end

#     find('div.icon-link', text: '2. Particulars').click

#     within('div.sidebar') do
#       expect(page).to have_content('Personal Information')
#       expect(page).to have_content('Name')
#       expect(page).to have_content('Date of Birth')
#       expect(page).to have_content('Gender')
#       expect(page).to have_content('Contact Information')
#       expect(page).to have_content('Mobile Number')
#       expect(page).to have_content('Email Address')
#       expect(page).to have_content('Home Number')
#       expect(page).to have_content('Office Number')
#       expect(page).to have_content('Passport Details')
#       expect(page).to have_content('Nationality')
#       expect(page).to have_content('Passport Number')
#       expect(page).to have_content('Passport Expiry Date')
#       expect(page).to have_content('Residential Details')
#       expect(page).to have_content('Residential Address')
#       expect(page).to have_content('Type of Residence')
#       expect(page).to have_content('Residential Status')
#       expect(page).to have_content('Number of years at this residence')
#       expect(page).to have_content('Professional Details')
#       expect(page).to have_content('Education Level')
#       expect(page).to have_content('Current Job Status')
#       expect(page).to have_content('Occupation')
#       expect(page).to have_content('Job Industry')
#       expect(page).to have_content('Company Name')
#       expect(page).to have_content('Length of Current Employment')
#       expect(page).to have_content('Current Job Status')
#       expect(page).to have_content('Current Office Address')
#     end
#   end

#   scenario "Documents required changes based on employment type" do
#     visit pages_documentupload_path

#     find('button#button2').click
#     find('div.icon-link', text: '1. Documents').click

#     expect(page).to have_css('li#item-tab3', visible: false)

#     find('button#button3').click

#     expect(page).to have_css('li#item-tab4', visible: false)
#   end
# end
