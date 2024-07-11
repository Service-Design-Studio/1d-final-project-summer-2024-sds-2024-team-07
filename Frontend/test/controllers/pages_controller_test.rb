require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get cardoptions" do
    get pages_cardoptions_url
    assert_response :success
  end

  test "should get apply" do
    get pages_apply_url
    assert_response :success
  end

  test "should get documentupload" do
    get pages_documentupload_url
    assert_response :success
  end

  test "should get applicationform" do
    get pages_applicationform_url
    assert_response :success
  end
end
