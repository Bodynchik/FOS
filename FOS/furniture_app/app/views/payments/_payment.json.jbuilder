json.extract! payment, :id, :order_id, :payment_method, :transaction_id, :payment_status, :payment_date, :created_at, :updated_at
json.url payment_url(payment, format: :json)
