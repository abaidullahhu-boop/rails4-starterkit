# Compatibility shim for older gems/helpers that still reference
# the deprecated `Mime::JS` constant (common in Rails 3/4 era).
#
# Rails 5+ prefers `Mime[:js]` and may not define `Mime::JS` at all,
# which raises `NameError: uninitialized constant Mime::JS`.
#
if defined?(Mime)
  # Ensure a :js mime type exists.
  Mime::Type.register("text/javascript", :js) unless Mime::Type.lookup_by_extension(:js)

  # Define Mime::JS as an alias for Mime[:js] if missing.
  unless defined?(Mime::JS)
    Mime::JS = Mime[:js]
  end
end



