class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :subcat_id
      t.string :prod_name
      t.decimal :prod_price
      t.text :prod_desc
      t.boolean :prod_is_avail
      t.string :prode_image

      t.timestamps
    end
  end
end
