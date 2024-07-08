Feature: Document Upload
  As a foreigner applying for a credit card,
  I want to see the documents required for my application based on my employment type
  So that I can prepare and upload the correct documents.

  Scenario: Viewing documents for Salaried Employer A: More than 3 Months
    Given that I am on the document upload page
    When I click on the Salaried Employer A: More than 3 Months button
    Then I should see all tabs for Salaried Employer A: More than 3 Months
    And I should see the Valid Passport tab
    And I should see the Valid Employment Pass tab
    And I should see the Income Tax tab
    And I should see the Pay Slip tab
    And I should see the Proof of Singapore Address tab

  Scenario: Viewing documents for Salaried Employer B: Less than 3 months
    Given that I am on the document upload page
    When I click on the Salaried Employer B: Less than 3 months button
    Then I should see tabs for Salaried Employer B: Less than 3 months
    And I should see the Valid Passport tab
    And I should see the Valid Employment Pass tab
    And I should see the Pay Slip tab
    And I should see the Proof of Singapore Address tab

  Scenario: Viewing documents for Self-Employed/Commision-Based
    Given that I am on the document upload page
    When I click on the Self-Employed/Commision-Based button
    Then I should see tabs for Self-Employed/Commision-Based
    And I should see the Valid Passport tab
    And I should see the Valid Employment Pass tab
    And I should see the Income Tax tab
    And I should see the Proof of Singapore Address tab

  Scenario: Navigating to the application form page
    Given that I am on the document upload page
    When I click on the next button
    Then I should be brought to the application form page
  
##Sad Path
Feature: Document Upload - Sad Path
  As a foreigner applying for a credit card,
  I want to be informed of errors when something goes wrong during my document upload process
  So that I can take corrective actions or report the issue.

  Scenario: Error loading documents for Salaried Employer A: More than 3 Months
    Given that I am on the document upload page
    When I click on the Salaried Employer A: More than 3 Months button but it fails to load
    Then I should see an error message for Salaried Employer A

  Scenario: Error loading documents for Salaried Employer B: Less than 3 months
    Given that I am on the document upload page
    When I click on the Salaried Employer B: Less than 3 months button but it fails to load
    Then I should see an error message for Salaried Employer B

  Scenario: Error loading documents for Self-Employed/Commision-Based
    Given that I am on the document upload page
    When I click on the Self-Employed/Commision-Based button but it fails to load
    Then I should see an error message for Self-Employed/Commision-Based

  Scenario: Error navigating to the application form page
    Given that I am on the document upload page
    When I click on the next button but the application form fails to load
    Then I should see an error message for the application form
    And I should not be brought to the application form page

  Scenario: Attempting to load a non-existent tab
    Given that I am on the document upload page
    When I try to load a tab that does not exist
    Then I should see an error message for the invalid tab
