class AddFavoriteCategoriesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :favorite_categories, :string, array: true, default: []
  end
end
