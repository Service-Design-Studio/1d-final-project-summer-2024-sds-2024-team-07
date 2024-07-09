Feature: Customised User Experience for Document Upload
  As a foreigner who needs to submit multiple documents for card application, 
  I want the application process to be customised to my use case, such that the document checklist and document upload page shows only the documents I need to submit, and is also clear and concise with visual documentation of correct submissions 
  so that I am clear of what are the key documents required and their relevant pages before I begin my card application.

  Scenario: Finding documents required for Supplementary Credit Card application before beginning application
    Given that I am on the application checklist page
    When I click onto the "Supplementary Credit Card" section
    Then I should see what is required for my "Supplementary Credit Card" application
    Then I should be able to click onto the close icon
    And I should be returned to the application checklist page

  Scenario: Finding documents required for DBS Live Fresh Student Card application before beginning application
    Given that I am on the application checklist page
    When I click onto the "DBS Live Fresh Student Card" section
    Then I should see what is required for my "DBS Live Fresh Student Card" application
    Then I should be able to click onto the close icon
    And I should be returned to the application checklist page

  Scenario: Finding documents required for Principal Credit Card application before beginning application as a Singaporean salaried employee (more than 3 months)
    Given that I am on the application checklist page
    When I click onto the "Principal Credit Card" section
    Then I should see what is required for my "Principal Credit Card" application
    Then I should be able to click onto "Identification Document"
    And I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to an "Identification Document"
    Then I should be able to click onto "Financial Document"
    And I should no longer see the section under "Identification Document"
    And I should be able to see what "Financial Document" refers to
    And I should see the first image corresponding to "Financial Document"
    Then I should be able to click onto the "Next" button
    And I should see the Next image corresponding to "Financial Document"
    Then I should be able to click onto the "Prev" button
    And I should see the Prev image corresponding to "Financial Document"
    Then I should be able to click onto "Income Tax Notice of Assessment"
    And I should no longer see the section under "Financial Document"
    And I should be able to see what "Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to "Income Tax Notice of Assessment"
    Then I should be able to click onto the close icon
    And I should be returned to the application checklist page


  Scenario: Finding documents required for Principal Credit Card application before beginning application
    Given that I am on the application checklist page
    When I want to find the documents required for Principal Credit Card application
    Then I should be able to click onto the "Principal Credit Card" section
    And I should see the documents required for submission for a "Singaporean/Permanent Resident" who has employment type "Salaried Employee (length of employment more than 3 months)"
    Then I should be able to click onto the Singaporean/Permanent Resident "toggle" button
    And I shoud be able to see the document required for submission for a "Foreigner" who has employment type "Salaried Employee (length of employment more than 3 months)"
    Then I should be able to click onto the "Salaried Employee (length of employment less than 3 months)" tab
    And I should see the documents required for submission for a "Foreigner" who has employment type "Salaried Employee (length of employment less than 3 months)"
    Then I should be able to click onto the "toggle" button
    And I should see the documents required for submission for a "Singaporean/Permanent Resident" who has employment type "Salaried Employee (length of employment less than 3 months)"
    Then I should be able to click onto the "Variable/ Commission-based Employees/ Self-Employed" tab
    And I should see the documents required for submission for a "Singaporean/Permanent Resident" who has employment type "Variable/ Commission-based Employees/ Self-Employed"
    Then I should be able to click onto the "toggle" button
    And I should see the documents required for submission for a "Foreigner" who has employment type "Variable/ Commission-based Employees/ Self-Employed"

  Scenario: View the document details for salaried employee with more than 3 months for Singaporeans or PR
    Given I am on the application checklist page
    When I click on the "Principal Credit Cards" section
    Then the pop-up appears
    And I should see the documents required for submission for a "Singaporean/Permanent Resident" who has employment type "Salaried Employee (length of employment more than 3 months)"
    Then the I can click on the document name
    And I should see the details of the document 

  Scenario: View the document details for salaried employee with less than 3 months for foreigners
    Given I am on the application checklist page
    When the I click on the "Principal Credit Cards" section
    Then the pop-up appears
    And I should see the documents required for submission for a "Singaporean/Permanent Resident" who has employment type "Salaried Employee (length of employment more than 3 months)"
    Then I clicks on the "Foreigners" toggle
    And I should see the documents required for submission for a "Foreigners" who has employment type "Salaried Employee (length of employment more than 3 months)"
    Then I can click on the document name
    And I should see the details of the document


 