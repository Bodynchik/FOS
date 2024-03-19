class RemoveColumnsFromManufactures < ActiveRecord::Migration[7.1]
  def change
    remove_column :manufactures, :manufacture_name, :string
    remove_column :manufactures, :created_at, :datetime
    remove_column :manufactures, :updated_at, :datetime
  end
end
