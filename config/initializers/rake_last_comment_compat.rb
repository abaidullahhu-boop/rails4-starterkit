# Compatibility shim for older gems (e.g., rspec-rails) that call
# Rake::Application#last_comment, which was removed in newer Rake versions.
#
module Rake
  class Application
    def last_comment
      respond_to?(:last_description) ? last_description : nil
    end
  end
end


