class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.string :client_surname
      t.string :client_patron
      t.string :email
      t.string :password
      t.string :phone

      t.timestamps
    end
  end
end
