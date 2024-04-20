ActiveAdmin.register Manufacturer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :person_name, :person_last_name, :person_middle_name, :title_manufacturer, :phone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :person_name, :person_last_name, :person_middle_name, :title_manufacturer, :phone_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :person_name
    column :person_last_name
    column :person_middle_name
    column :title_manufacturer
    column :phone_number
    column :email
    column :created_at
    actions
  end

  filter :person_name
  filter :person_last_name
  filter :person_middle_name
  filter :title_manufacturer
  filter :phone_number
  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :person_name
      f.input :person_last_name
      f.input :person_middle_name
      f.input :title_manufacturer
      f.input :phone_number
      f.input :email
      # f.input :password
      # f.input :password_confirmation
    end
    f.actions
  end
  
end
