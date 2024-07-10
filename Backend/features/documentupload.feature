Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know and upload the required documents based on my job employment status
  So that I can upload the correct documents

  Scenario: Salaried Employee for more than 3 months
    Given that I am on the document upload page
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Salaried Employee A button
    When I click on the Salaried Employee A button
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
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Salaried Employee B button
    When I click on the Salaried Employee B button
    Then I should be able to see a "Passport" information
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    Then I should be able to click onto the "Pay Slip" tab
    And I should be able to see "Pay Slip" information
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information

  Scenario: Commissioned-Based Employee/Self-Employed
    Given that I am on the document upload page
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Self-Employed or Commision-Based button
    When I click on the Self-Employed or Commision-Based button
    Then I should be able to see a "Passport" information
    Then I should be able to click onto the "Employment Pass" tab
    And I should be able to see "Employment Pass" information
    Then I should be able to click onto the "Income Tax" tab
    And I should be able to see "Income Tax" information
    Then I should be able to click onto the "Proof of Address" tab
    And I should be able to see "Proof of Address" information