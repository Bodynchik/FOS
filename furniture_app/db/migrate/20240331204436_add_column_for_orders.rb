class AddColumnForOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
  end
end
