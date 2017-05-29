class CreateAdminConfigurationIdentifiers < ActiveRecord::Migration
  def change
    create_table :admin_configuration_identifiers do |t|
      t.text :identifier

      t.timestamps null: false
    end
  end
end
