require 'test_helper'

class Admin::NotebooksControllerTest < ActionController::TestCase
  setup do
    @admin_notebook = admin_notebooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_notebooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_notebook" do
    assert_difference('Admin::Notebook.count') do
      post :create, admin_notebook: { category_id: @admin_notebook.category_id, description: @admin_notebook.description }
    end

    assert_redirected_to admin_notebook_path(assigns(:admin_notebook))
  end

  test "should show admin_notebook" do
    get :show, id: @admin_notebook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_notebook
    assert_response :success
  end

  test "should update admin_notebook" do
    patch :update, id: @admin_notebook, admin_notebook: { category_id: @admin_notebook.category_id, description: @admin_notebook.description }
    assert_redirected_to admin_notebook_path(assigns(:admin_notebook))
  end

  test "should destroy admin_notebook" do
    assert_difference('Admin::Notebook.count', -1) do
      delete :destroy, id: @admin_notebook
    end

    assert_redirected_to admin_notebooks_path
  end
end
