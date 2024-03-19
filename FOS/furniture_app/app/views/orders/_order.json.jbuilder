json.extract! order, :id, :client_id, :order_date, :postcode, :order_total_val, :order_status, :created_at, :updated_at
json.url order_url(order, format: :json)
