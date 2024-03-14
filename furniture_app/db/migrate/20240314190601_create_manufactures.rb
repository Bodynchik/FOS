class CreateManufactures < ActiveRecord::Migration[7.1]
  def change
    create_table :manufactures do |t|
      t.string :manufacture_name
      t.string :manufacture_country

      t.timestamps
    end
  end
end
