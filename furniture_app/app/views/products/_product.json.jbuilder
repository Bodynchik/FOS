json.extract! product, :id, :subcat_id, :prod_name, :prod_price, :prod_desc, :prod_is_avail, :prode_image, :created_at, :updated_at
json.url product_url(product, format: :json)
