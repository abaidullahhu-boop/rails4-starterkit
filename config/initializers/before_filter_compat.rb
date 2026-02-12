# Compatibility shim for older gems/controllers that still call
# before_filter / prepend_before_filter / append_before_filter on
# ActionController::Base. Rails 5+ renamed these to *_action.
#
if defined?(ActionController::Base)
  class ActionController::Base
    class << self
      alias_method :before_filter, :before_action if respond_to?(:before_action) && !respond_to?(:before_filter)
      alias_method :prepend_before_filter, :prepend_before_action if respond_to?(:prepend_before_action) && !respond_to?(:prepend_before_filter)
      alias_method :append_before_filter, :append_before_action if respond_to?(:append_before_action) && !respond_to?(:append_before_filter)
    end
  end
end


