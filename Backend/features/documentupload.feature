Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know and upload the required documents based on my job employment status
  So that I can upload the correct documents

  Scenario: Salaried Employee for more than 3 months
    Given that I am on the document upload page
    When I want to find the documents I'm required to upload
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
    When I want to find the documents I'm required to upload
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
    When I want to find the documents I'm required to upload
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
    When I want to find the documents I am required to upload
    Then I should be able to click on the Document side bar 
    When I click on to the Document side bar
    Then I should see the documents required for Salaried Employee : More than 3 Months
    And I should be able to click on Salaried Employee : Less than 3 months
    When I click on to the Salaried Employee : Less than 3 months button
    Then I should see the documents required for Salaried Employee : Less than 3 months
    And I should be able to click on to the Self-Employed or Commission-Based button
    When I click on the Self-Employed or Commission-Based button
    And I should see the documents required for Self-Employed or Commission-Based button