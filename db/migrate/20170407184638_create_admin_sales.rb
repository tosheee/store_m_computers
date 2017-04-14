class CreateAdminSales < ActiveRecord::Migration
  def change
    create_table :admin_sales do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :full_name
      t.string :phone
      t.string :email
      t.string :domain
      t.string :city
      t.text :addres
      t.text :comment

      t.timestamps null: false
    end
  end
end
