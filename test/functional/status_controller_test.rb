require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  test "should get get" do
    get :get
    assert_response :success
  end

end
