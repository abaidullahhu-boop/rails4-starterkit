require 'addressable/uri'

module DeviseRoutesHelper

  # Override login path to include return_to param
  def new_user_session_path
    add_return_to_path('new_user_session_path')
  end

  # Override sign up path to include return_to param
  def new_user_registration_path
    add_return_to_path('new_user_registration_path')
  end

  def add_return_to_path(path_name)
    urls = Rails.application.routes.url_helpers
    if valid_after_sign_in_path?
      urls.method(path_name).call(return_to: request.fullpath)
    else
      urls.method(path_name).call
    end
  end

  def valid_after_sign_in_path?(path = request.fullpath)
    p = Addressable::URI.parse(path)
    # In the original Rails 4 app these prefixes came from
    # Rails.application.config.auth.omniauth/devise.path_prefix.
    # That legacy Settingslogic-based config is no longer wired up,
    # so we hard-code the current Devise prefix ('/a') and omit the
    # social auth prefix (disabled for now).
    prevent_urls = [
      "^#{root_path}$",
      "^/a/"
    ]
    p.present? and (p.host.blank? or p.host == ENV['CANONICAL_HOST']) and p.path.match(prevent_urls.join('|')).blank?
  end
end
