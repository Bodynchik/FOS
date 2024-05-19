class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show]

  def show
    sort_by = params[:sort] || 'prod_model'
    direction = params[:direction] || 'asc'

    @sort_direction = direction == 'asc' ? 'desc' : 'asc'
    products_query = SortQuery.sort_products(@manufacturer.products, sort_by, direction)
    @products = products_query.page(params[:page]).per(10)
  end

  private

  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
