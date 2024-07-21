json.extract! user, :id, :name, :passport_number, :passport_expiry, :date_of_birth, :doc_passport, :doc_employment_pass, :doc_income_tax, :doc_payslip, :doc_proof_of_address, :others, :created_at, :updated_at
json.url user_url(user, format: :json)
