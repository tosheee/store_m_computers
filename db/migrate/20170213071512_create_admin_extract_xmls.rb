class CreateAdminExtractXmls < ActiveRecord::Migration
  def change
    create_table :admin_extract_xmls do |t|
      t.string :name
      t.string :attachment

      t.timestamps null: false
    end
  end
end
