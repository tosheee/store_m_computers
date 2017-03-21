class CreateAdminCategories < ActiveRecord::Migration
  def change
    create_table :admin_categories do |t|
      t.string :name_cat
      t.integer :view_cat

      t.timestamps null: false
    end
  end
end
