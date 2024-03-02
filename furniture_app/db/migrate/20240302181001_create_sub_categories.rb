class CreateSubCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_categories do |t|
      t.integer :cat_id
      t.string :subcat_name

      t.timestamps
    end
  end
end
