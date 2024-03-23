class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :middle_name, :string
    add_column :users, :phone_number, :string, null: false, default: ""
    add_index :users, :phone_number, unique: true
  end
end