class Manufacturers::ProfilesController < ApplicationController
  def show
    @manufacturer = current_manufacturer.id
    @product = Product.new
    @furniture_name = Furniture.all.map { |f| [f.name, f.id] }
    @sub_category_name = SubCategory.all.map { |f| [f.subcat_name, f.id] }
  end
end
