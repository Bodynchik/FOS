class CreateProdSets < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :prod_sets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :set_name
      t.hstore :prod_data

      t.timestamps
    end
  end
end
