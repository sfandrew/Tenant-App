require 'test_helper'

class ApisControllerTest < ActionController::TestCase
  test "should get contact_field" do
    get :contact_field
    assert_response :success
  end

end
