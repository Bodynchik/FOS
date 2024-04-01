class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :furniture, null: false, foreign_key: true
      t.references :manufacturer, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true
      t.string :prod_model
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
