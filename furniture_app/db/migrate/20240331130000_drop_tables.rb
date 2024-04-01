class DropTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :ordered_products
    drop_table :carts
    drop_table :payments
    drop_table :orders
    drop_table :prod_raitings
    drop_table :prod_reviews
    drop_table :products
    drop_table :manufactures
    drop_table :clients
  end
end
