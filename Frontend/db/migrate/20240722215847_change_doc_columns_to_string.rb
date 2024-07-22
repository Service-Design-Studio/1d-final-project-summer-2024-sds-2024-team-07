class ChangeDocColumnsToString < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :doc_passport, :string
    change_column :users, :doc_employment_pass, :string
    change_column :users, :doc_income_tax, :string
    change_column :users, :doc_payslip, :string
    change_column :users, :doc_proof_of_address, :string
    change_column :users, :others, :string
  end
end
