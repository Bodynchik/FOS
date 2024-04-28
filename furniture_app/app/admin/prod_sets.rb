ActiveAdmin.register ProdSet do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :set_name, :prod_data
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :set_name, :prod_data]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :user do |set|
      set.user.username
    end
    column :set_name
    column :prod_data do |set|
      prod_data = set.prod_data
      if prod_data.present?
        product_id, quantity = prod_data.first
        product = Product.find_by(id: product_id)
        "#{product.furniture.name}: #{quantity}шт."
      end
    end
    column :created_at
    actions
  end

  filter :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
  filter :set_name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
      f.input :set_name
      f.input :prod_data, as: :text, input_html: { rows: 5 }
    end

    f.actions
  end
end
