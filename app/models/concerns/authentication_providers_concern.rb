module AuthenticationProvidersConcern
  extend ActiveSupport::Concern

  def provider_name
    self.class.provider_name(provider)
  end

  def logout_url
    self.class.logout_url(provider)
  end

  def username_for_display
    self.class.username_for_display(username, provider)
  end

  module ClassMethods
    def providers(type = :login)
      # In the original Rails 4 app these values came from
      # Rails.application.config.auth (backed by Settingslogic and
      # config/auth.yml). That legacy configuration layer has been
      # removed/disabled during the Rails 7 upgrade, so referencing it
      # now raises `undefined method 'auth'` on the app configuration.
      #
      # To keep the app functional without legacy social auth, we
      # simply disable external providers for now by returning an
      # empty list. The login UI will hide provider buttons when this
      # is empty.
      []
    end

    def allow_multiple_for?(provider)
      false
    end

    def provider_name(provider)
      provider.to_s.titleize
    end

    def username_for_display(username, provider = nil)
      case provider.to_sym
      when :twitter
        "@#{username}"
      else
        username
      end
    end

    def logout_url(provider)
      '#'
    end
  end
end
