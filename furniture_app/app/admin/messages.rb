ActiveAdmin.register Message do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :content, :chat_id, :user_id, :manufacturer_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :chat_id, :user_id, :manufacturer_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :content
    column :chat do |message|
      message.chat.id
    end
    column :user do |message|
      message.user.username if message.user.present?
    end
    column :manufacturer do |message|
      message.manufacturer.username if message.manufacturer.present?
    end
    column :created_at
    actions
  end

  filter :chat_id, as: :select, collection: Chat.all.map { |c| [c.id] }
  filter :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
  filter :manufacturer_id, as: :select, collection: Manufacturer.all.map { |m| [m.username, m.id] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :chat_id, as: :select, collection: Chat.all.map { |c| [c.id] }
      f.input :user_id, as: :select, collection: User.all.map { |u| [u.username, u.id] }
      f.input :manufacturer_id, as: :select, collection: Manufacturer.all.map { |m| [m.username, m.id] }
      f.input :content
    end

    f.actions
  end
end
