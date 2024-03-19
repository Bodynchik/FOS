class CreateOrderedProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :ordered_products do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :prod_amount

      t.timestamps
    end
  end
end
