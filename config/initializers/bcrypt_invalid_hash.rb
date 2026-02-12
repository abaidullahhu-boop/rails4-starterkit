# Global safety net for legacy / invalid bcrypt hashes during upgrade.
# Any time BCrypt::Password.new is called with an invalid hash string,
# we return a password object backed by a random hash so that all
# comparisons simply fail instead of raising BCrypt::Errors::InvalidHash.

require 'securerandom'

if defined?(BCrypt::Password)
  class BCrypt::Password
    class << self
      alias_method :new_without_invalid_hash_rescue, :new

      def new(hash)
        new_without_invalid_hash_rescue(hash)
      rescue BCrypt::Errors::InvalidHash
        # Create a dummy password hash that will never match any
        # real plaintext password, but won't crash the app either.
        create(SecureRandom.hex(32))
      end
    end
  end
end


