require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get foundry_crm" do
    get foundry_crm_path
    assert_response :success
  end
end
