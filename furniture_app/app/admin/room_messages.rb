ActiveAdmin.register RoomMessage do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :body, :room_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:body, :room_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :room do |message|
      message.room&.category_name
    end
    column :user do |message|
      message.user&.username
    end
    column :body
    actions
  end

  filter :room_id
  filter :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
  filter :body

  form do |f|
    f.inputs do
      f.input :room_id
      f.input :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
      f.input :body
    end
    f.actions
  end
end
