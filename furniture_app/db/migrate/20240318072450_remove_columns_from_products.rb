class RemoveColumnsFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :created_at, :datetime
    remove_column :products, :updated_at, :datetime
  end
end
