class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :order_date
      t.string :postcode
      t.integer :order_total_val
      t.string :order_status

      t.timestamps
    end
  end
end
