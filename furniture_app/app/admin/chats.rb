ActiveAdmin.register Chat do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :manufacturer_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :manufacturer_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :user do |chat|
      chat.user.username
    end
    column :manufacturer do |chat|
      chat.manufacturer.username
    end
    column :created_at
    actions
  end

  filter :user_id, as: :select, collection: User.all.map {|u| [u.username, u.id]}
  filter :manufacturer_id, as: :select, collection: Manufacturer.all.map {|m| [m.username, m.id]}
  filter :created_at
  
end
