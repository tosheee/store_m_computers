require 'test_helper'

class Admin::LaptopsControllerTest < ActionController::TestCase
  setup do
    @admin_laptop = admin_laptops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_laptops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should edit admin_laptop" do
    assert_difference('Admin::Laptop.count') do
      post :edit, admin_laptop: { Model: @admin_laptop.Model, category: @admin_laptop.category, category_id: @admin_laptop.category_id, classname: @admin_laptop.classname, code: @admin_laptop.code, currency: @admin_laptop.currency, gallery: @admin_laptop.gallery, general_description: @admin_laptop.general_description, hashpromo: @admin_laptop.hashpromo, main_picture_url: @admin_laptop.main_picture_url, manufacturer: @admin_laptop.manufacturer, name: @admin_laptop.name, partnum: @admin_laptop.partnum, price: @admin_laptop.price, product_status: @admin_laptop.product_status, property_Audio: @admin_laptop.property_Audio, property_Battery: @admin_laptop.property_Battery, property_Bluetooth: @admin_laptop.property_Bluetooth, property_Body_Color: @admin_laptop.property_Body_Color, property_CPU: @admin_laptop.property_CPU, property_Camera: @admin_laptop.property_Camera, property_Dimensions: @admin_laptop.property_Dimensions, property_Disk_Specifications: @admin_laptop.property_Disk_Specifications, property_Graphics: @admin_laptop.property_Graphics, property_HDD: @admin_laptop.property_HDD, property_Interface: @admin_laptop.property_Interface, property_LAN: @admin_laptop.property_LAN, property_Manufacturer: @admin_laptop.property_Manufacturer, property_Memory_size: @admin_laptop.property_Memory_size, property_Memory_type: @admin_laptop.property_Memory_type, property_Mnfr_Part: @admin_laptop.property_Mnfr_Part, property_Model: @admin_laptop.property_Model, property_ODD: @admin_laptop.property_ODD, property_OS: @admin_laptop.property_OS, property_Other: @admin_laptop.property_Other, property_SSD: @admin_laptop.property_SSD, property_Screen_Resolution: @admin_laptop.property_Screen_Resolution, property_Screen_size: @admin_laptop.property_Screen_size, property_Screen_type: @admin_laptop.property_Screen_type, property_Warranty: @admin_laptop.property_Warranty, property_Weight: @admin_laptop.property_Weight, property_Wi-Fi: @admin_laptop.property_Wi-Fi, vendor_url: @admin_laptop.vendor_url }
    end

    assert_redirected_to admin_laptop_path(assigns(:admin_laptop))
  end

  test "should show admin_laptop" do
    get :show, id: @admin_laptop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_laptop
    assert_response :success
  end

  test "should update admin_laptop" do
    patch :update, id: @admin_laptop, admin_laptop: { Model: @admin_laptop.Model, category: @admin_laptop.category, category_id: @admin_laptop.category_id, classname: @admin_laptop.classname, code: @admin_laptop.code, currency: @admin_laptop.currency, gallery: @admin_laptop.gallery, general_description: @admin_laptop.general_description, hashpromo: @admin_laptop.hashpromo, main_picture_url: @admin_laptop.main_picture_url, manufacturer: @admin_laptop.manufacturer, name: @admin_laptop.name, partnum: @admin_laptop.partnum, price: @admin_laptop.price, product_status: @admin_laptop.product_status, property_Audio: @admin_laptop.property_Audio, property_Battery: @admin_laptop.property_Battery, property_Bluetooth: @admin_laptop.property_Bluetooth, property_Body_Color: @admin_laptop.property_Body_Color, property_CPU: @admin_laptop.property_CPU, property_Camera: @admin_laptop.property_Camera, property_Dimensions: @admin_laptop.property_Dimensions, property_Disk_Specifications: @admin_laptop.property_Disk_Specifications, property_Graphics: @admin_laptop.property_Graphics, property_HDD: @admin_laptop.property_HDD, property_Interface: @admin_laptop.property_Interface, property_LAN: @admin_laptop.property_LAN, property_Manufacturer: @admin_laptop.property_Manufacturer, property_Memory_size: @admin_laptop.property_Memory_size, property_Memory_type: @admin_laptop.property_Memory_type, property_Mnfr_Part: @admin_laptop.property_Mnfr_Part, property_Model: @admin_laptop.property_Model, property_ODD: @admin_laptop.property_ODD, property_OS: @admin_laptop.property_OS, property_Other: @admin_laptop.property_Other, property_SSD: @admin_laptop.property_SSD, property_Screen_Resolution: @admin_laptop.property_Screen_Resolution, property_Screen_size: @admin_laptop.property_Screen_size, property_Screen_type: @admin_laptop.property_Screen_type, property_Warranty: @admin_laptop.property_Warranty, property_Weight: @admin_laptop.property_Weight, property_Wi-Fi: @admin_laptop.property_Wi-Fi, vendor_url: @admin_laptop.vendor_url }
    assert_redirected_to admin_laptop_path(assigns(:admin_laptop))
  end

  test "should destroy admin_laptop" do
    assert_difference('Admin::Laptop.count', -1) do
      delete :destroy, id: @admin_laptop
    end

    assert_redirected_to admin_laptops_path
  end
end
