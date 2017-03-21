require 'test_helper'

class Admin::SubCategoriesControllerTest < ActionController::TestCase
  setup do
    @admin_sub_category = admin_sub_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sub_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_sub_category" do
    assert_difference('Admin::SubCategory.count') do
      post :create, admin_sub_category: { category_id: @admin_sub_category.category_id, name: @admin_sub_category.name }
    end

    assert_redirected_to admin_sub_category_path(assigns(:admin_sub_category))
  end

  test "should show admin_sub_category" do
    get :show, id: @admin_sub_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_sub_category
    assert_response :success
  end

  test "should update admin_sub_category" do
    patch :update, id: @admin_sub_category, admin_sub_category: { category_id: @admin_sub_category.category_id, name: @admin_sub_category.name }
    assert_redirected_to admin_sub_category_path(assigns(:admin_sub_category))
  end

  test "should destroy admin_sub_category" do
    assert_difference('Admin::SubCategory.count', -1) do
      delete :destroy, id: @admin_sub_category
    end

    assert_redirected_to admin_sub_categories_path
  end
end
