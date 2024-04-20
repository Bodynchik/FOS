ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price, :description, :delivery_days, :production_days
  #
  # or
  #
  # permit_params do
  #   permitted = [:furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price, :description, :delivery_days, :production_days]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :furniture_id do |product|
      product.furniture.name
    end
    column :manufacturer_id do |product|
      product.manufacturer.title_manufacturer
    end
    column :sub_category_id do |product|
      product.sub_category.subcat_name
    end
    column :prod_model
    column :price
    column :description
    column :delivery_days
    column :production_days
    column :created_at
    actions
  end

  filter :furniture_id, as: :select, collection: Furniture.all.map {|f| [f.name, f.id]}
  filter :manufacturer_id, as: :select, collection: Manufacturer.all.map {|m| [m.title_manufacturer, m.id]}
  filter :sub_category_id, as: :select, collection: SubCategory.all.map {|c| [c.subcat_name, c.id]}
  filter :prod_model
  filter :price
  filter :description
  filter :delivery_days
  filter :production_days
  filter :created_at

  form do |f|
    f.inputs do
      f.input :furniture_id, as: :select, collection: Furniture.all.map {|u| [u.name, u.id]}
      f.input :manufacturer_id, as: :select, collection: Manufacturer.all.map {|m| [m.title_manufacturer, m.id]}
      f.input :sub_category_id, as: :select, collection: SubCategory.all.map {|c| [c.subcat_name, c.id]}
      f.input :prod_model
      f.input :price
      f.input :description
      f.input :delivery_days
      f.input :production_days
    end
    f.actions
  end
  
end
