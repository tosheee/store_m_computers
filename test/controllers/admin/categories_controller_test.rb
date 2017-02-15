require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  setup do
    @admin_category = admin_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should edit admin_category" do
    assert_difference('Admin::Category.count') do
      post :edit, admin_category: { name_cat: @admin_category.name_cat, view_cat: @admin_category.view_cat }
    end

    assert_redirected_to admin_category_path(assigns(:admin_category))
  end

  test "should show admin_category" do
    get :show, id: @admin_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_category
    assert_response :success
  end

  test "should update admin_category" do
    patch :update, id: @admin_category, admin_category: { name_cat: @admin_category.name_cat, view_cat: @admin_category.view_cat }
    assert_redirected_to admin_category_path(assigns(:admin_category))
  end

  test "should destroy admin_category" do
    assert_difference('Admin::Category.count', -1) do
      delete :destroy, id: @admin_category
    end

    assert_redirected_to admin_categories_path
  end
end
