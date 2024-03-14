class CreateProdRaitings < ActiveRecord::Migration[7.1]
  def change
    create_table :prod_raitings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.integer :raiting_val

      t.timestamps
    end
  end
end
