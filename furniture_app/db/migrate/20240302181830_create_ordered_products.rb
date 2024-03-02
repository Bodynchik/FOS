class CreateOrderedProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :ordered_products do |t|
      t.integer :order_id
      t.integer :prod_id
      t.integer :prod_amount

      t.timestamps
    end
  end
end
