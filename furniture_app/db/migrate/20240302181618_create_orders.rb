class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.date :order_date
      t.string :postcode
      t.decimal :order_total_val
      t.string :order_status

      t.timestamps
    end
  end
end
