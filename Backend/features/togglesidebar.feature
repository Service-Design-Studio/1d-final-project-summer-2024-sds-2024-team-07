Feature: Toggle Sidebar
  As a foreigner who is applying for a credit card,
  I want to be able to see everything that I am required to submit without having to key in any information
  So that I can prepare the information required for credit card application.

  Scenario: Viewing details within the same page on the sidebar
    Given that I am on the document upload page
    When I want to find the information of the documents required on the document upload page
    Then I should be able to click onto the sidebar
    And I should see information of each section of each page within the sidebar
    And when I click on a section that belongs to the current page
    Then my screen slides to the respective section

  Scenario: Viewing details of application page on the sidebar
    Given that I am on the document upload page
    When I want to find the information of the application form without having submitted my documents yet
    Then I should be able to click onto the sidebar
    And I should see other pages' headers on the sidebar such as "Particulars"
    And when I click on the header of the sidebar
    Then a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page

  Scenario: Clicking on the 'Next' button
    Given that I am on the document upload page
    When I finish viewing the document upload page
    And I want to go to the application form page
    Then I should be able to click onto the 'Next' button
    And I should be brought to the application form page

  Scenario: Viewing details of document uploads on the sidebar
    Given that I am on the application form page
    When I want to find the information of the document upload page 
    And I should see other pages' headers on the sidebar such as "Documents"
    And when I click on the header of the sidebar
    Then a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page