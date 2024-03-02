json.extract! ordered_product, :id, :order_id, :prod_id, :prod_amount, :created_at, :updated_at
json.url ordered_product_url(ordered_product, format: :json)
