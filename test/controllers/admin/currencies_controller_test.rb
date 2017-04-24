require 'test_helper'

class Admin::CurrenciesControllerTest < ActionController::TestCase
  setup do
    @admin_currency = admin_currencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_currencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_currency" do
    assert_difference('Admin::Currency.count') do
      post :create, admin_currency: { identifier: @admin_currency.identifier, name: @admin_currency.name, rate_equals: @admin_currency.rate_equals }
    end

    assert_redirected_to admin_currency_path(assigns(:admin_currency))
  end

  test "should show admin_currency" do
    get :show, id: @admin_currency
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_currency
    assert_response :success
  end

  test "should update admin_currency" do
    patch :update, id: @admin_currency, admin_currency: { identifier: @admin_currency.identifier, name: @admin_currency.name, rate_equals: @admin_currency.rate_equals }
    assert_redirected_to admin_currency_path(assigns(:admin_currency))
  end

  test "should destroy admin_currency" do
    assert_difference('Admin::Currency.count', -1) do
      delete :destroy, id: @admin_currency
    end

    assert_redirected_to admin_currencies_path
  end
end
