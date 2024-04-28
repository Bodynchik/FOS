ActiveAdmin.register SubCategory do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :category_id, :subcat_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:category_id, :subcat_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :category_id do |sub_category|
      sub_category.category.cat_name
    end
    column :subcat_name
    actions
  end

  filter :category_id, as: :select, collection: Category.all.map { |c| [c.cat_name, c.id] }
  filter :subcat_name

  form do |f|
    f.inputs do
      f.input :category_id, as: :select, collection: Category.all.map { |c| [c.cat_name, c.id] }
      f.input :subcat_name
    end
    f.actions
  end
end
