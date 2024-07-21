require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { date_of_birth: @user.date_of_birth, doc_employment_pass: @user.doc_employment_pass, doc_income_tax: @user.doc_income_tax, doc_passport: @user.doc_passport, doc_payslip: @user.doc_payslip, doc_proof_of_address: @user.doc_proof_of_address, name: @user.name, others: @user.others, passport_expiry: @user.passport_expiry, passport_number: @user.passport_number } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { date_of_birth: @user.date_of_birth, doc_employment_pass: @user.doc_employment_pass, doc_income_tax: @user.doc_income_tax, doc_passport: @user.doc_passport, doc_payslip: @user.doc_payslip, doc_proof_of_address: @user.doc_proof_of_address, name: @user.name, others: @user.others, passport_expiry: @user.passport_expiry, passport_number: @user.passport_number } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
