class CreateProdReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :prod_reviews do |t|
      t.references :product, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.text :review_text

      t.timestamps
    end
  end
end
