Feature: Customised User Experience for Document Upload
  As a foreigner who needs to submit multiple documents for card application, 
  I want the application process to be customised to my use case, such that the document checklist and document upload page shows only the documents I need to submit, and is also clear and concise with visual documentation of correct submissions 
  so that I am clear of what are the key documents required and their relevant pages before I begin my card application.

  Scenario: Viewing documents required for Singaporean salaried employee (more than 3 months)
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    When I click onto "Financial Document"
    Then I should no longer see the section under "Identification Document"
    And I should see what "Financial Document" refers to
    And I should see the first image corresponding to "Financial Document"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Financial Document"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Financial Document"
    When I click onto "Income Tax Notice of Assessment"
    Then I should no longer see the section under "Financial Document"
    And I should see what "Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Income Tax Notice of Assessment"
    Then I should be able to click onto the close icon
    Then I should be returned to the application checklist page

  Scenario: Viewing documents required for Singaporean salaried employee (less than 3 months)
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    When I click onto "Salaried Employee (less than 3 months)" tab
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    And I click onto "Financial Document"
    Then I should no longer see the section under "Identification Document"
    And I should see what "Financial Document" refers to
    And I should see an image corresponding to a "Financial Document"
    Then I should be able to click onto the close icon
    And I should be returned to the application checklist page

  Scenario: Viewing documents required for Singaporean Variable/Commission-based Employees or Self-Employed
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    When I click onto "Variable/Commission-based Employees or Self-Employed" tab
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    And I click onto "Income Tax Notice of Assessment"
    Then I should no longer see the section under "Identification Document"
    And I should see what "Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Income Tax Notice of Assessment"
    Then I should be able to click onto the close icon
    And I should be returned to the application checklist page

  Scenario: Viewing documents required for Foreigners salaried employee (more than 3 months)
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    When I click on "Singaporean or Permanent Resident" toggle
    And I have clicked on "Singaporean or Permanent Resident" toggle
    Then I should be able to see what "Valid Passport" refers to
    And I should see an image corresponding to a "Valid Passport"
    And I have clicked onto "Employment Pass"
    Then I should be able to see what "Employment Pass" refers to
    And I should see the first image corresponding to "Employment Pass"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Employment Pass"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Employment Pass"
    And I have clicked onto "Latest Income Tax Notice of Assessment"
    Then I should be able to see what "Latest Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Latest Income Tax Notice of Assessment"
    And I have clicked onto "Latest Computerised Payslip"
    Then I should be able to see what "Latest Computerised Payslip" refers to
    And I should see an image corresponding to a "Latest Computerised Payslip"
    And I have clicked onto "Proof of Residential Address"
    Then I should be able to see what "Proof of Residential Address" refers to
    And I should see the first image corresponding to "Proof of Residential Address"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Proof of Residential Address"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Proof of Residential Address"

Scenario: Viewing documents required for Foreigners salaried employee (less than 3 months)
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    When I click on "Singaporean or Permanent Resident" toggle 
    And I have clicked on "Singaporean or Permanent Resident" toggle
    And I have clicked onto "Salaried Employee (less than 3 months)" tab
    Then I should be able to see what "Valid Passport" refers to
    And I should see an image corresponding to a "Valid Passport"
    And I have clicked onto "Employment Pass"
    Then I should be able to see what "Employment Pass" refers to
    And I should see the first image corresponding to "Employment Pass"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Employment Pass"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Employment Pass"
    And I have clicked onto "Proof of Employment"
    Then I should be able to see what "Proof of Employment" refers to
    And I should see the first image corresponding to "Proof of Employment"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Proof of Employment"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Proof of Employment"
    And I have clicked onto "Proof of Residential Address"
    Then I should be able to see what "Proof of Residential Address" refers to
    And I should see the first image corresponding to "Proof of Residential Address"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Proof of Residential Address"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Proof of Residential Address"

  Scenario: Viewing documents required for Foreigners Variable/Commission-based Employees or Self-Employed
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    When I click on "Singaporean or Permanent Resident" toggle
    And I have clicked on "Singaporean or Permanent Resident" toggle
    And I have clicked onto "Variable/Commission-based Employees or Self-Employed" tab
    Then I should be able to see what "Valid Passport" refers to
    And I should see an image corresponding to a "Valid Passport"
    And I have clicked onto "Employment Pass"
    Then I should be able to see what "Employment Pass" refers to
    And I should see the first image corresponding to "Employment Pass"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Employment Pass"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Employment Pass"
    And I have clicked onto "Latest Income Tax Notice of Assessment"
    Then I should be able to see what "Latest Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Latest Income Tax Notice of Assessment"
    And I have clicked onto "Proof of Residential Address"
    Then I should be able to see what "Proof of Residential Address" refers to
    And I should see the first image corresponding to "Proof of Residential Address"
    And I click onto the "Next" button
    Then I should see the next image corresponding to "Proof of Residential Address"
    When I click onto the "Prev" button
    And I should see the previous image corresponding to "Proof of Residential Address"


  Scenario: The choosen header will restart to the default header when change type of User
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    When I click onto "Income Tax Notice of Assessment"
    Then I should be able to see what "Latest Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Latest Income Tax Notice of Assessment"
    When I click onto "Salaried Employee (less than 3 months)" tab
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    And I click onto "Financial Document"
    Then I should no longer see the section under "Identification Document"
    And I should see what "Financial Document" refers to
    And I should see an image corresponding to a "Financial Document"
    When I click onto "Variable/Commission-based Employees or Self-Employed" tab
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    And I click onto "Income Tax Notice of Assessment"
    Then I should no longer see the section under "Identification Document"
    And I should see what "Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Income Tax Notice of Assessment"
    When I click onto "Salaried Employee (less than 3 months)" tab
    Then I should not be able to see what "Income Tax Notice of Assessment" refers to 
    And I should not be able to see an image corresponding to a "Income Tax Notice of Assessment"
    And I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    When I click onto "Salaried Employee (more than 3 months)" tab
    Then I should not be able to see what "Financial Document" refers to
    And I should not be able to see an image corresponding to a "Financial Document"
    And I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"

  Scenario: The choosen header will restart to the default header when the toggle is clicked
    Given that I am on the application checklist page
    And I have clicked onto the "Principal Credit Card" section
    Then I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"
    When I click onto "Income Tax Notice of Assessment"
    Then I should be able to see what "Income Tax Notice of Assessment" refers to
    And I should see an image corresponding to a "Income Tax Notice of Assessment"
    When I click on "Singaporean or Permanent Resident" toggle 
    Then I should be able to see what "Valid Passport" refers to
    And I should see an image corresponding to a "Valid Passport"
    When I click on "Singaporean or Permanent Resident" toggle 
    Then I should not be able to see what "Income Tax Notice of Assessment" refers to
    And I should not be able to see an image corresponding to a "Income Tax Notice of Assessment"
    And I should be able to see what "Identification Document" refers to
    And I should see an image corresponding to a "Identification Document"