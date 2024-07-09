Feature: Toggle Sidebar
  As a foreigner who is applying for a credit card,
  I want to be able to see everything that I am required to submit without having to key in any information
  So that I can prepare the information required for credit card application.

  Scenario: Viewing details within the same page on the sidebar
    Given that I am on the document upload page
    Then I should see other pages' headers on the sidebar
    And all headers should be clickable
    And I should see information of each section of each page within the sidebar
    When I click on a section that belongs to the current page
    Then my screen slides to the respective section

  Scenario: Viewing details of application page on the sidebar
    Given I am on the document upload page and I want to find information of the application form page without having submitted my documents yet
    Then I should see other pages' headers on the sidebar
    When I click on the header "2. Particulars"
    Then a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page

  Scenario: Viewing details of document uploads on the sidebar
    Given that I am on the application form page
    When I want to find the information of the document upload page
    And I should see the headers of other pages on the sidebar such as "1. Documents"
    When I click on the header "1. Documents"
    Then a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page
