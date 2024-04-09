class AddProductionDeliveryDaysProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :delivery_days, :string, array: true, default: []
    add_column :products, :production_days, :integer
  end
end
