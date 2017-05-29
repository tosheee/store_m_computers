require 'test_helper'

class Admin::ConfigurationIdentifiersControllerTest < ActionController::TestCase
  setup do
    @admin_configuration_identifier = admin_configuration_identifiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_configuration_identifiers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_configuration_identifier" do
    assert_difference('Admin::ConfigurationIdentifier.count') do
      post :create, admin_configuration_identifier: { identifier: @admin_configuration_identifier.identifier }
    end

    assert_redirected_to admin_configuration_identifier_path(assigns(:admin_configuration_identifier))
  end

  test "should show admin_configuration_identifier" do
    get :show, id: @admin_configuration_identifier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_configuration_identifier
    assert_response :success
  end

  test "should update admin_configuration_identifier" do
    patch :update, id: @admin_configuration_identifier, admin_configuration_identifier: { identifier: @admin_configuration_identifier.identifier }
    assert_redirected_to admin_configuration_identifier_path(assigns(:admin_configuration_identifier))
  end

  test "should destroy admin_configuration_identifier" do
    assert_difference('Admin::ConfigurationIdentifier.count', -1) do
      delete :destroy, id: @admin_configuration_identifier
    end

    assert_redirected_to admin_configuration_identifiers_path
  end
end
