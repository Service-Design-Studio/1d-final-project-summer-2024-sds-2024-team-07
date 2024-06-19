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
    And I should be able to see a side bar that is open that shows the required information for the form application
    Then I should be able to click on the toggle of the side bar to close the side bar

  Scenario 2: Viewing details within the same page on side bar
    Given that I have am on the document upload page
    When I want to find the information of the documents required in the document upload page
    Then I should be able to click onto the sidebar
    And I should see information of each section of each page within the sidebar
    Then I click on a section that belongs to the current page
    And my screen slides to the respective section

  Scenario 3: Viewing details of other pages on side bar
    Given that I have clicked into the document upload page
    When I want to find the information of the application form having not submitted my documents yet
    Then I should be able to click onto the sidebar
    And I should see other pages headers on the sidebar such as "Application Details"
    Then I should be able to click on the header of the sidebar
    And a dropdown displaying the information of the sections within that page should appear
    And I should not be able to click on a section that belongs to that page