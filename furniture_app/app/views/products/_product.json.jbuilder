json.extract! product, :id, :furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
