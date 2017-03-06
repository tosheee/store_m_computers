class CreateAdminSubCategories < ActiveRecord::Migration
  def change
    create_table :admin_sub_categories do |t|
      t.integer :category_id
      t.string :name
      t.string :identifier
      t.timestamps null: false
    end
    add_index :admin_sub_categories, :name
    add_index :admin_sub_categories, :identifier
  end
end
