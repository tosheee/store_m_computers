class CreateAdminLaptops < ActiveRecord::Migration
  def change
    create_table :admin_laptops do |t|
      t.integer :category_id
      t.string :code
      t.string :name
      t.string :product_status
      t.string :hashpromo
      t.string :general_description
      t.string :classname
      t.string :price
      t.string :currency
      t.text   :main_picture_url
      t.string :manufacturer
      t.string :category
      t.string :partnum
      t.text   :gallery
      t.string :vendor_url
      t.string :property_manufacturer
      t.string :property_mnfr_part
      t.string :property_model
      t.string :property_screen_size
      t.string :property_screen_type
      t.string :property_screen_resolution
      t.string :property_memory_size
      t.string :property_memory_type
      t.string :property_cpu
      t.string :model
      t.string :property_graphics
      t.string :property_hdd
      t.string :property_ssd
      t.string :property_disk_specifications
      t.string :property_interface
      t.string :property_camera
      t.string :property_odd
      t.string :property_os
      t.string :property_wi_fi
      t.string :property_audio
      t.string :property_lan
      t.string :property_bluetooth
      t.string :property_body_color
      t.string :property_battery
      t.string :property_dimensions
      t.string :property_weight
      t.string :property_other
      t.string :property_warranty

      t.timestamps null: false
    end
  end
end
