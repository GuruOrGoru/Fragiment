class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :log_request
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_storage_current

  private

  def set_active_storage_current
    ActiveStorage::Current.url_options = { host: request.host, port: request.port, protocol: request.protocol }
  end

  def log_request
    Rails.logger.info "#{request.method} #{request.path} by user #{current_user&.id || 'guest'} from #{request.remote_ip}"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :avatar ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :avatar ])
  end
end
