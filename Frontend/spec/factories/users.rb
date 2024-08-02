# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    passport_number { "123456789" }
    passport_expiry { "2024-12-31" }
    date_of_birth { "1990-01-01" }
    doc_passport { "doc_passport.png" }
    doc_employment_pass { "doc_employment_pass.png" }
    doc_income_tax { "doc_income_tax.png" }
    doc_payslip { "doc_payslip.png" }
    doc_proof_of_address { "doc_proof_of_address.png" }
    others { "other_document.png" }
    session_id { SecureRandom.uuid }
  end
end
