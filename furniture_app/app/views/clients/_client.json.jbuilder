json.extract! client, :id, :client_name, :client_surname, :client_patron, :email, :password, :phone, :created_at, :updated_at
json.url client_url(client, format: :json)
