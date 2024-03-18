class RemoveColumnsFromCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :created_at, :datetime
    remove_column :categories, :updated_at, :datetime
  end
end
