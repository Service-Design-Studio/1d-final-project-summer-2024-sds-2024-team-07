Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know and upload the required documents based on my job employment status
  So that I can upload the correct documents
  
  Scenario: Salaried Employee for more than 3 months
    Given that I am on the document upload page
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Salaried Employee : More than 3 Months button
    When I click on the Salaried Employee : More than 3 Months button
    Then I should be able to see a "Passport" information
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    Then I should be able to click onto the "Income Tax" tab
    And I should be able to see "Income Tax" information
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to see "Pay Slip" information
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information

  Scenario: Salaried Employee for less than 3 months
    Given that I am on the document upload page
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Salaried Employee : Less than 3 months button
    When I click on the Salaried Employee : Less than 3 months button
    Then I should be able to see a "Passport" information
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to see "Pay Slip" information
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information

  Scenario: Commissioned-Based Employee/Self-Employed
    Given that I am on the document upload page
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Self-Employed or Commission-Based button
    When I click on the Self-Employed or Commission-Based button
    Then I should be able to see a "Passport" information
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    Then I should be able to click onto the "Income Tax" tab
    And I should be able to see "Income Tax" information
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information

  Scenario: Side Bar Change according to the type of user
    Given that I am at the document upload page
    Then I should be able to click on the Document side bar 
    When I click on to the Document side bar
    Then I should see the documents required for Salaried Employee : More than 3 Months
    And I should be able to click on Salaried Employee : Less than 3 months
    When I click on to the Salaried Employee : Less than 3 months button
    Then I should see the documents required for Salaried Employee : Less than 3 months
    And I should be able to click on to the Self-Employed or Commission-Based button
    When I click on the Self-Employed or Commission-Based button
    And I should see the documents required for Self-Employed or Commission-Based button

  Scenario: Uploading documents successfully
    Given that I am on the document upload page
    When I click “Document Upload” button
    And I should be able to choose a file
    Then I should see “Document Uploaded”

  Scenario: Failed document upload
    Given that I am on the document upload page
    When I click “Document Upload” button
    And I choose a wrong file
    Then I should see a pop up warning

  Scenario: Foreigner application process
    Given that I am on the apply page
    When I click on the "Application Checklist Page"
    Then I should be brought to the "Application Checklist Page"
    When I click on the "Application Page"
    Then I should be brought to the "Application Page"
    When I click on the "Document Upload Button"
    Then I should be brought to the "Document Upload Page"