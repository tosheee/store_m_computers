class UpdateForeignKeyProducts < ActiveRecord::Migration
  def change
    remove_foreign_key :order_items, :admin_product_features
    add_foreign_key :order_items, :admin_product_features, on_delete: :cascade
  end
end
