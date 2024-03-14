json.extract! cart, :id, :client_id, :product_id, :prod_amount, :created_at, :updated_at
json.url cart_url(cart, format: :json)
