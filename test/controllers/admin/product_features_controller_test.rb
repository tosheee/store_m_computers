require 'test_helper'

class Admin::ProductFeaturesControllerTest < ActionController::TestCase
  setup do
    @admin_product_feature = admin_product_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_product_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_product_feature" do
    assert_difference('Admin::ProductFeature.count') do
      post :create, admin_product_feature: { category_id: @admin_product_feature.category_id, description: @admin_product_feature.description, product_id: @admin_product_feature.product_id }
    end

    assert_redirected_to admin_product_feature_path(assigns(:admin_product_feature))
  end

  test "should show admin_product_feature" do
    get :show, id: @admin_product_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_product_feature
    assert_response :success
  end

  test "should update admin_product_feature" do
    patch :update, id: @admin_product_feature, admin_product_feature: { category_id: @admin_product_feature.category_id, description: @admin_product_feature.description, product_id: @admin_product_feature.product_id }
    assert_redirected_to admin_product_feature_path(assigns(:admin_product_feature))
  end

  test "should destroy admin_product_feature" do
    assert_difference('Admin::ProductFeature.count', -1) do
      delete :destroy, id: @admin_product_feature
    end

    assert_redirected_to admin_product_features_path
  end
end
