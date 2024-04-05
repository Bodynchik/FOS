class AddProductionDeliveryDaysProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :production_days, :integer
    add_column :products, :delivery_days, :text
  end
end
