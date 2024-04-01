json.extract! order, :id, :product_id, :quantity, :total_price, :created_at, :updated_at
json.url order_url(order, format: :json)
