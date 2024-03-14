json.extract! product, :id, :sub_category_id, :prod_name, :prod_price, :manufacture_id, :prod_desc, :prod_avail_amount, :prod_raiting, :created_at, :updated_at
json.url product_url(product, format: :json)
