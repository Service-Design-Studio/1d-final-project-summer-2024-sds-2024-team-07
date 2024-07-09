Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know and upload the required documents based on my job employment status
  So that I can upload the correct documents

  Scenario: Salaried Employee for more than 3 months
    Given that I am on the document upload page
    And I am a salaried employee of more than 3 months
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status 
    And I should be able to click onto the Salaried Employee A button
    When I click on the Salaried Employee A button
    Then I should be able to see 5 documents: Passport, Employment Pass, Income Tax, PaySlip and Proof of Address
    And I should see the sample document and document guidlines under the document names
    And I should see those same documents on the sidebar under Documents

  Scenario: Salaried Employee for less than 3 months
    Given that I am on the document upload page
    And I am a salaried employee of more than 3 months
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status
    And I should be able to click onto the Salaried Employee B button
    When I click on the Salaried Employee A button
    Then I should be able to see 4 documents: Passport, Employment Pass,PaySlip and Proof of Address
    And I should see the sample document and document guidlines under the document names
    And I should see those same documents on the sidebar under Documents

  Scenario: Commissioned-Based Employee/Self-Employed
    Given that I am on the document upload page
    And Commissioned-Based Employee/Self-Employed
    When I want to find the documents I'm required to upload
    Then I should be able to see 3 different buttons for the different employment status
    Then I should be able to click onto the Commisioned-Based Employee button
    When I click on the Salaried Employee A button
    Then I should be able to see 4 documents: Passport, Employment Pass, Income Tax and Proof of Address
        And I should see the sample document and document guidlines under the document names
    And I should see those same documents on the sidebar under Documents



  Scenario: After uploading a document
    Given that I click on the Upload Document Button
    And the file window pops up to prompt me to upload the document
    When I click on the document that I want to upload
    Then the next tab should automatically open
    And I should see the next document to upload
    And I should see the respective sample document and guidelines
