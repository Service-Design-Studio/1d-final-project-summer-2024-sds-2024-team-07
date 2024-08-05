Feature: OCR Autofill
  As a foreigner who is applying for a credit card,
  I want to be able to have my information autofilled corresponding to the submitted documents
  So that I [dunnid do anything?]
  
  Scenario: Successful and correct extraction of personal details from submitted documents
    Given that I am on the document upload page
    When I click on “Document Upload” button
    And I should able to choose the file corresponding to Passport
    And I should see a delete button
    Given that I am on the application form page
    Then I should see my information filled in

  Scenario: Wrong text extracted from documents
    Given that I am on the document upload page
    When I click on “Document Upload” button
    And I should able to choose the file corresponding to Passport
    And I should see a delete button
    Given that I am on the application form page
    When I click on the "Your preferred name to appear on the card(s)" field
    Then I should be able to type "Kara Wong"
    When I click on the "Title" dropdown field
    Then I should be able to select "Ms"
    When I click on the "Office Number" field
    Then I should be able to type "62353535"