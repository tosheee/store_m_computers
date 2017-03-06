class CreateAdminProductFeatures < ActiveRecord::Migration
  def change
    create_table :admin_product_features do |t|
      t.integer :category_id
      t.integer :sub_category_id
      t.string :identifier
      t.text :description

      t.timestamps null: false
    end
    add_index :admin_product_features, :identifier
  end
end
