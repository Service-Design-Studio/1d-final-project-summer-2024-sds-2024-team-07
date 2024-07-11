require "test_helper"

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get one" do
    get test_one_url
    assert_response :success
  end
end
