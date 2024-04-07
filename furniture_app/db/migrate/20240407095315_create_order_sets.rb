class CreateOrderSets < ActiveRecord::Migration[7.1]
  def change
    create_table :order_sets do |t|
      t.references :prod_set, null: false, foreign_key: true
      t.decimal :total_price

      t.timestamps
    end
  end
end
