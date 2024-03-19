class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :payment_method
      t.integer :transaction_id
      t.string :payment_status
      t.datetime :payment_date

      t.timestamps
    end
  end
end
