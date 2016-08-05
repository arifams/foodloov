class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Add login as an attr_accessor for devise as devise wiki asked for it
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # actually on docs said we need to use devise_parameter_sanitizer.for but on rails +4.1 we use devise_parameter_sanitizer.permit
  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
  devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

end
