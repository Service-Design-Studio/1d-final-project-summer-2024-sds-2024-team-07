Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know that I have submitted the correct documents that correspond to the documents required
  So that I know that I have uploaded the correct documents
  
  Scenario: Successful document uploads for Salaried Employee for more than 3 months
    Given that I am on the document upload page
    Then I should see that I am on the tab for "Salaried Employee for more than 3 months"
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Employment Pass"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Income Tax" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Income Tax"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Pay Slip" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Pay Slip"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    When I click "Next" button
    Then I should be brought to the "Application Form Page"

  Scenario: Successful document uploads for Salaried Employee for less than 3 months
    Given that I am on the document upload page
    Then I should see that I am on the tab for "Salaried Employee for more than 3 months"
    And I should be able to click on Salaried Employee : Less than 3 months
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Income Tax"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Pay Slip" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Pay Slip"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    When I click "Next" button
    Then I should be brought to the "Application Form Page"

  Scenario: Successful document uploads for Commissioned-Based Employee/Self-Employed
    Given that I am on the document upload page
    Then I should see that I am on the tab for "Salaried Employee for more than 3 months"
    And I should be able to click on to the Self-Employed or Commission-Based button
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Employment Pass"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Income Tax" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Income Tax"
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    When I click "Next" button
    Then I should be brought to the "Application Form Page"

  Scenario: Wrong file type document upload
    Given that I am on the document upload page
    And I should be able to choose a file of the wrong file format
    Then I should be able to close the error message

  Scenario: Wrong details document upload for "Pay Slip"
    Given that I am on the document upload page
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to choose a file not corresponding to "Pay Slip" but is still the correct file format
    Then I should be able to close the error message

  Scenario: Changing uploaded document
    Given that I am on the document upload page
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should be able to click the "Delete" button
    Then I should see the "Document Upload" button