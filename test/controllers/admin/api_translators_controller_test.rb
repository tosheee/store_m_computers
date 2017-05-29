require 'test_helper'

class Admin::ApiTranslatorsControllerTest < ActionController::TestCase
  setup do
    @admin_api_translator = admin_api_translators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_api_translators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_api_translator" do
    assert_difference('Admin::ApiTranslator.count') do
      post :create, admin_api_translator: { worlds: @admin_api_translator.worlds }
    end

    assert_redirected_to admin_api_translator_path(assigns(:admin_api_translator))
  end

  test "should show admin_api_translator" do
    get :show, id: @admin_api_translator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_api_translator
    assert_response :success
  end

  test "should update admin_api_translator" do
    patch :update, id: @admin_api_translator, admin_api_translator: { worlds: @admin_api_translator.worlds }
    assert_redirected_to admin_api_translator_path(assigns(:admin_api_translator))
  end

  test "should destroy admin_api_translator" do
    assert_difference('Admin::ApiTranslator.count', -1) do
      delete :destroy, id: @admin_api_translator
    end

    assert_redirected_to admin_api_translators_path
  end
end
