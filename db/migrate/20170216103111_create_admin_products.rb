class CreateAdminProducts < ActiveRecord::Migration
  def change
    create_table :admin_products do |t|
      t.integer :category_id
      t.text :description

      t.timestamps null: false
    end
  end
end
