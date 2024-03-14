class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :prod_amount

      t.timestamps
    end
  end
end
