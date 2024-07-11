Feature: Document Upload
  As a foreigner who is applying for a credit card,
  I want to be able to know and upload the required documents based on my job employment status
  So that I can upload the correct documents
    
  Scenario: Failed document upload
    Given that I am on the document upload page
    When I click “Document Upload” button
    And I choose a wrong file
    Then I should see a pop up warning