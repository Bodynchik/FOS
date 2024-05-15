ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at,
                :first_name, :last_name, :middle_name, :phone_number, :unconfirmed_email, :currency
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :first_name, :last_name, :middle_name, :phone_number, :unconfirmed_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :middle_name
    column :phone_number
    column :email
    column :currency
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :middle_name
  filter :phone_number
  filter :email
  filter :currency
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :middle_name
      f.input :phone_number
      f.input :email
      f.input :currency
      # f.input :password
      # f.input :password_confirmation
    end
    f.actions
  end
end
