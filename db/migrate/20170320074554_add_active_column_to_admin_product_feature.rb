class AddActiveColumnToAdminProductFeature < ActiveRecord::Migration
  def change
    add_column :admin_product_features, :active, :boolean, :default => true
  end
end
