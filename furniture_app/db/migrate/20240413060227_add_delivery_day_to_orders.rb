class AddDeliveryDayToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :delivery_day, :datetime
  end
end
