class RemoveColumnsFromSubCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :sub_categories, :created_at, :datetime
    remove_column :sub_categories, :updated_at, :datetime
  end
end
