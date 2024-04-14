class AddColumnsToManufacturers < ActiveRecord::Migration[7.1]
  def change
    add_column :manufacturers, :person_name, :string, null: false, default: ''
    add_column :manufacturers, :person_last_name, :string, null: false, default: ''
    add_column :manufacturers, :person_middle_name, :string
    add_column :manufacturers, :title_manufacturer, :string, null: false, default: ''
    add_column :manufacturers, :phone_number, :string, null: false, default: ''

    add_index :manufacturers, :title_manufacturer, unique: true
    add_index :manufacturers, :phone_number, unique: true
  end
end
