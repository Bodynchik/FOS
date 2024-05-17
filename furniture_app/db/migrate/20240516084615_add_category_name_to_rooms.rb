class AddCategoryNameToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :category_name, :string
  end
end
