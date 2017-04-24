class CreateAdminCurrencies < ActiveRecord::Migration
  def change
    create_table :admin_currencies do |t|
      t.string :name
      t.string :identifier
      t.decimal :rate_equals, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
