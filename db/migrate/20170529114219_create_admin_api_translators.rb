class CreateAdminApiTranslators < ActiveRecord::Migration
  def change
    create_table :admin_api_translators do |t|
      t.text :worlds

      t.timestamps null: false
    end
  end
end
