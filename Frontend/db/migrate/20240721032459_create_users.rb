class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :passport_number
      t.date :passport_expiry
      t.date :date_of_birth
      t.string :doc_passport
      t.string :doc_employment_pass
      t.string :doc_income_tax
      t.string :doc_payslip
      t.string :doc_proof_of_address
      t.string :others

      t.timestamps
    end
  end
end
