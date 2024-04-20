ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :product_id, :quantity, :total_price, :user_id, :delivery_day
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_id, :quantity, :total_price, :user_id, :delivery_day]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :product_id do |order|
      order.product.furniture.name
    end
    column :quantity
    column :total_price
    column :user do |order|
      order.user.username
    end
    column :delivery_day
    column :created_at
    actions
  end

  filter :product_id, as: :select, collection: Product.all.map {|f| [f.furniture.name, f.id]}
  filter :user_id, as: :select, collection: User.all.map {|u| [u.username, u.id]}
  filter :quantity
  filter :total_price
  filter :created_at
  filter :delivery_day

  form do |f|
    f.inputs do
      f.input :product_id, as: :select, collection: Product.all.map {|f| [f.furniture.name, f.id]}
      f.input :user_id, as: :select, collection: User.all.map {|u| [u.username, u.id]}
      f.input :quantity
      f.input :total_price
      f.input :delivery_day
    end
    f.actions
  end
  
end
