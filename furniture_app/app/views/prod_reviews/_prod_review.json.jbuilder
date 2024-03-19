json.extract! prod_review, :id, :product_id, :client_id, :review_text, :created_at, :updated_at
json.url prod_review_url(prod_review, format: :json)
