class ProductQuery
  def initialize(manufacturer)
    @manufacturer = manufacturer
  end

  def products
    @manufacturer.products
  end

  def to_csv
    attributes = %w[furniture_type name price descriptions production_days delivery]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      products.each do |product|
        csv << [
          product.furniture.name,
          "#{product.furniture.name} (#{product.prod_model})",
          product.price,
          product.description,
          product.production_days,
          product.delivery_days.join(', ')
        ]
      end
    end
  end
end