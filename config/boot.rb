# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# Global compatibility shim for older gems that still define controller
# callbacks using before_filter / prepend_before_filter, which were
# renamed in Rails 5+ to *_action.
class Module
  def before_filter(*args, &block)
    if respond_to?(:before_action)
      before_action(*args, &block)
    else
      raise NoMethodError, "before_filter is not supported on #{self}"
    end
  end

  def prepend_before_filter(*args, &block)
    if respond_to?(:prepend_before_action)
      prepend_before_action(*args, &block)
    else
      raise NoMethodError, "prepend_before_filter is not supported on #{self}"
    end
  end

  def after_filter(*args, &block)
    if respond_to?(:after_action)
      after_action(*args, &block)
    else
      raise NoMethodError, "after_filter is not supported on #{self}"
    end
  end

  # Basic implementation of Rails' old alias_method_chain helper, used by
  # several legacy gems. It defines method_without_feature and then replaces
  # the original with method_with_feature.
  def alias_method_chain(target, feature)
    without = :"#{target}_without_#{feature}"
    with    = :"#{target}_with_#{feature}"
    alias_method without, target
    alias_method target, with
  end
end

