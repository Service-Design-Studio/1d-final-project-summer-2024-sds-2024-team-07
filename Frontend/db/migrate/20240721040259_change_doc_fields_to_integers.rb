class ChangeDocFieldsToIntegers < ActiveRecord::Migration[7.1]
  def change
    # Adding temporary columns with integer type
    add_column :users, :doc_passport_temp, :integer
    add_column :users, :doc_employment_pass_temp, :integer
    add_column :users, :doc_income_tax_temp, :integer
    add_column :users, :doc_payslip_temp, :integer
    add_column :users, :doc_proof_of_address_temp, :integer
    add_column :users, :others_temp, :integer

    # Copying data from old columns to temporary columns
    User.reset_column_information
    User.find_each do |user|
      user.update_columns(
        doc_passport_temp: user.doc_passport.to_i,
        doc_employment_pass_temp: user.doc_employment_pass.to_i,
        doc_income_tax_temp: user.doc_income_tax.to_i,
        doc_payslip_temp: user.doc_payslip.to_i,
        doc_proof_of_address_temp: user.doc_proof_of_address.to_i,
        others_temp: user.others.to_i
      )
    end

    # Removing old columns
    remove_column :users, :doc_passport
    remove_column :users, :doc_employment_pass
    remove_column :users, :doc_income_tax
    remove_column :users, :doc_payslip
    remove_column :users, :doc_proof_of_address
    remove_column :users, :others

    # Renaming temporary columns to original names
    rename_column :users, :doc_passport_temp, :doc_passport
    rename_column :users, :doc_employment_pass_temp, :doc_employment_pass
    rename_column :users, :doc_income_tax_temp, :doc_income_tax
    rename_column :users, :doc_payslip_temp, :doc_payslip
    rename_column :users, :doc_proof_of_address_temp, :doc_proof_of_address
    rename_column :users, :others_temp, :others
  end
end
