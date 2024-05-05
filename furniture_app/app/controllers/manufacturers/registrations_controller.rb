# frozen_string_literal: true

class Manufacturers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :check_email_domain, only: [:create]
  before_action :check_info_manufacturers, only: [:create]

  # GET /resource/sign_up
  # def new
  #  super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def check_email_domain
    return if params[:manufacturer][:email].end_with?('@karazin.ua')

    redirect_to new_manufacturer_registration_path, alert: t('flash.manufacturers.errors.email_check')
  end

  def check_info_manufacturers
    email = params[:manufacturer][:email]
    title_manufacturer = params[:manufacturer][:title_manufacturer]
    phone_number = params[:manufacturer][:phone_number]
    if Manufacturer.exists?(email:)
      redirect_to new_manufacturer_registration_path, alert: t('flash.manufacturers.errors.email')
    elsif Manufacturer.exists?(title_manufacturer:)
      redirect_to new_manufacturer_registration_path, alert: t('flash.manufacturers.errors.name')
    elsif Manufacturer.exists?(phone_number:)
      redirect_to new_manufacturer_registration_path, alert: t('flash.manufacturers.errors.phone')
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[person_name person_last_name person_middle_name title_manufacturer
                                               phone_number])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[person_name person_last_name person_middle_name title_manufacturer
                                               phone_number])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
