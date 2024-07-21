require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url
    click_on "New user"

    fill_in "Date of birth", with: @user.date_of_birth
    fill_in "Doc employment pass", with: @user.doc_employment_pass
    fill_in "Doc income tax", with: @user.doc_income_tax
    fill_in "Doc passport", with: @user.doc_passport
    fill_in "Doc payslip", with: @user.doc_payslip
    fill_in "Doc proof of address", with: @user.doc_proof_of_address
    fill_in "Name", with: @user.name
    fill_in "Others", with: @user.others
    fill_in "Passport expiry", with: @user.passport_expiry
    fill_in "Passport number", with: @user.passport_number
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "should update User" do
    visit user_url(@user)
    click_on "Edit this user", match: :first

    fill_in "Date of birth", with: @user.date_of_birth
    fill_in "Doc employment pass", with: @user.doc_employment_pass
    fill_in "Doc income tax", with: @user.doc_income_tax
    fill_in "Doc passport", with: @user.doc_passport
    fill_in "Doc payslip", with: @user.doc_payslip
    fill_in "Doc proof of address", with: @user.doc_proof_of_address
    fill_in "Name", with: @user.name
    fill_in "Others", with: @user.others
    fill_in "Passport expiry", with: @user.passport_expiry
    fill_in "Passport number", with: @user.passport_number
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "should destroy User" do
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end
