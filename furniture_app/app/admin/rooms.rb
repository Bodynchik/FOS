ActiveAdmin.register Room do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :category_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:category_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :category_name
    actions
  end

  filter :category_name

  form do |f|
    f.inputs do
      f.input :category_name, as: :select, collection: Category.pluck(:cat_name)
    end
    f.actions
  end
end
