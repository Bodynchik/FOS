class SortQuery
  def self.sort_products(products, sort_by, direction)
    sort_direction = direction == 'asc' ? 'ASC' : 'DESC'
    case sort_by
    when 'name'
      products.order(prod_model: direction.to_sym)
    when 'price'
      products.order(price: direction.to_sym)
    when 'average_rating'
      products.left_joins(:comments)
              .group('products.id')
              .order(Arel.sql("COALESCE(AVG(comments.rating), 0) #{sort_direction}"))
    # when 'average_rating'
    #   products.joins(:comments)
    #           .group('products.id')
    #           .order("AVG(comments.rating) #{sort_direction}")
    when 'comments_count'
      products.left_joins(:comments)
              .group('products.id')
              .order("COUNT(comments.id) #{sort_direction}")
    when 'production_days'
      products.order(production_days: direction.to_sym)
    else
      products
    end
  end
end
