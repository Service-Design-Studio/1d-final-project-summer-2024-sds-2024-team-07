require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get page_one" do
    get pages_page_one_url
    assert_response :success
  end
end
