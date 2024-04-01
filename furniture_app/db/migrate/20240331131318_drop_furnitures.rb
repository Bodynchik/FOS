class DropFurnitures < ActiveRecord::Migration[7.1]
  def change
    drop_table :furnitures
  end
end
