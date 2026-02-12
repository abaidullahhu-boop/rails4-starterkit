class Users::RegistrationsController < Devise::RegistrationsController
  # Thin wrapper around Devise's default registrations controller.
  # We only extend it by permitting extra attributes during sign up
  # and account update. All other behavior is the standard Devise flow.

  SANITIZED_PARAMS = [:first_name, :last_name].freeze

  # In development we relax CSRF verification on create to avoid issues
  # with legacy forms while upgrading the app. Do NOT copy this into
  # production.
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { Rails.env.development? }

  before_action :configure_permitted_parameters, only: [:create, :update]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: SANITIZED_PARAMS)
    devise_parameter_sanitizer.permit(:account_update, keys: SANITIZED_PARAMS)
  end
end


