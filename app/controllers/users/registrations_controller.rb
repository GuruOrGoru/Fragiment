class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  def update
    # Auto-set password_confirmation to password if not provided
    if params[:user][:password].present? && params[:user][:password_confirmation].blank?
      params[:user][:password_confirmation] = params[:user][:password]
    end
    # Remove password fields if blank to avoid validation errors
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    super
  end

  protected

  def update_resource(resource, params)
    # Update without requiring current password
    resource.update(params)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :bio, :favorite_languages, :avatar ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :bio, :favorite_languages, :avatar, :password, :password_confirmation ])
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
