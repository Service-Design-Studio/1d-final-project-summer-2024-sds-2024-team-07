Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know that I have submitted the correct documents that correspond to the documents required
  So that I know that I have uploaded the correct documents
  
  Scenario: Successful document uploads for Salaried Employee for more than 3 months
    Given that I am on the document upload page
    Then I should see that I am on the tab for "Salaried Employee for more than 3 months"
    Then I should be able to see a "Passport" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Employment Pass"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Income Tax" tab
    And I should be able to see "Income Tax" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Income Tax"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to see "Pay Slip" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Pay Slip"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    Then I should see “Document Uploaded”
    When I click "Next" button
    Then I should be brought to the application form page

  Scenario: Successful document uploads for Salaried Employee for less than 3 months
    Given that I am on the document upload page
    When I click on the Salaried Employee : Less than 3 months button
    Then I should be able to see a "Passport" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Employment Pass"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to see "Pay Slip" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Pay Slip"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    Then I should see “Document Uploaded”
    When I click "Next" button
    Then I should be brought to the application form page

  Scenario: Successful document uploads for Commissioned-Based Employee/Self-Employed
    Given that I am on the document upload page
    When I click on the Self-Employed or Commission-Based button
    Then I should be able to see a "Passport" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Passport"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Employment Pass"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Income Tax" tab
    And I should be able to see "Income Tax" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Income Tax"
    Then I should see “Document Uploaded”
    Then I should not be able to click on the "Next" button
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information
    When I click “Document Upload” button
    And I should be able to choose a file corresponding to "Proof of Address"
    Then I should see “Document Uploaded”
    When I click "Next" button
    Then I should be brought to the application form page

  Scenario: Wrong file type document upload
    Given that I am on the document upload page
    And I am uploading for any document
    When I click “Document Upload” button
    And I should be able to choose a file of the wrong file format
    Then I should see a pop up warning that says "Invalid file type! Please upload a PDF, PNG, or JPG document."

  Scenario: Wrong details document upload for "Passport"
    Given that I am on the document upload page
    And I am uploading for "Passport"
    When I click “Document Upload” button
    And I should be able to choose a file not corresponding to "Passport" but is still the correct file format
    Then I should see a pop up warning that says "Document Invalid. Please submit an appropriate document."

  Scenario: Wrong details document upload for "Employment Pass"
    Given that I am on the document upload page
    And I am uploading for "Employment Pass"
    When I click “Document Upload” button
    And I should be able to choose a file not corresponding to "Employment Pass" but is still the correct file format
    Then I should see a pop up warning that says "Document Invalid. Please submit an appropriate document."

  Scenario: Wrong details document upload for "Income Tax"
    Given that I am on the document upload page
    And I am uploading for "Income Tax"
    When I click “Document Upload” button
    And I should be able to choose a file not corresponding to "Income Tax" but is still the correct file format
    Then I should see a pop up warning that says "Document Invalid. Please submit an appropriate document."

  Scenario: Wrong details document upload for "Pay Slip"
    Given that I am on the document upload page
    And I am uploading for "Pay Slip"
    When I click “Document Upload” button
    And I should be able to choose a file not corresponding to "Pay Slip" but is still the correct file format
    Then I should see a pop up warning that says "Document Invalid. Please submit an appropriate document."

  Scenario: Wrong details document upload for "Proof of Address"
    Given that I am on the document upload page
    And I am uploading for "Proof of Address"
    When I click “Document Upload” button
    And I should be able to choose a file not corresponding to "Proof of Address" but is still the correct file format
    Then I should see a pop up warning that says "Document Invalid. Please submit an appropriate document."

  Scenario: Changing uploaded document
    Given that I am on the document upload page
    And I am uploading for any document
    When I click “Document Upload” button
    And I upload a correct document
    Then I should see “Document Uploaded”
    And I should be able to click the "Delete" button
    Then I should see the "Document Upload" button

  Scenario: Losing the Documents previously uploaded if type of user is changed
    Given that I am on the document upload page
    When I want to upload my document
    Then I should be able to click “Document Upload” button
    And I should be able to choose a file
    Then I should see “Document Uploaded”
    Then I should be able to click on “Salaried Employee(less than 3 months)” button
    Then I should see a pop up warning that says "Do you wish to change your employment type? Your changes will be discarded."
    Then I should be able to click on "OK"
    Then I should be able to see the details of “Salaried Employee(less than 3 months)”
    Then I should be able to click on “Salaried Employee(more than 3 months)” button
    Then I should see the "Upload Document" button