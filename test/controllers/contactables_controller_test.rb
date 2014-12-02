require 'test_helper'

class ContactablesControllerTest < ActionController::TestCase
  setup do
    @contactable = contactables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contactables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contactable" do
    assert_difference('Contactable.count') do
      post :create, contactable: {  }
    end

    assert_redirected_to contactable_path(assigns(:contactable))
  end

  test "should show contactable" do
    get :show, id: @contactable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contactable
    assert_response :success
  end

  test "should update contactable" do
    patch :update, id: @contactable, contactable: {  }
    assert_redirected_to contactable_path(assigns(:contactable))
  end

  test "should destroy contactable" do
    assert_difference('Contactable.count', -1) do
      delete :destroy, id: @contactable
    end

    assert_redirected_to contactables_path
  end
end
