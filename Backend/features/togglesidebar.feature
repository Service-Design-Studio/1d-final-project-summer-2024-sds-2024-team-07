Feature: Toggle Sidebar
  As a foreigner who is applying for a credit card,
  I want to be able to see everything that I am required to submit without having to key in any information
  So that I can prepare the information required for credit card application.

  Scenario: Allowing foreigners to choose their employment type
    Given that I have clicked 'Upload your documents'
    When I see the options for employment type
    Then I should be able to click the employment type I currently have
    And I should be brought to the document upload page
    And I should see the required documents that I need to upload for my application
    And I should be able to see a sidebar that is open that shows the required information for the form application
    And I should be able to click on the toggle of the sidebar to close the sidebar

  Scenario: Viewing details within the same page on the sidebar
    Given that I am on the document upload page
    When I want to find the information of the documents required on the document upload page
    Then I should be able to click onto the sidebar
    And I should see information of each section of each page within the sidebar
    And when I click on a section that belongs to the current page
    Then my screen slides to the respective section

  Scenario: Viewing details of other pages on the sidebar
    Given that I am on the document upload page
    When I want to find the information of the application form without having submitted my documents yet
    Then I should be able to click onto the sidebar
    And I should see other pages' headers on the sidebar such as "Application Details"
    And when I click on the header of the sidebar
    Then a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page
