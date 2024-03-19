class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :sub_category, null: false, foreign_key: true
      t.string :prod_name
      t.decimal :prod_price
      t.references :manufacture, null: false, foreign_key: true
      t.text :prod_desc
      t.integer :prod_avail_amount
      t.decimal :prod_raiting

      t.timestamps
    end
  end
end
