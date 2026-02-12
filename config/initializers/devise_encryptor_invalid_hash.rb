# Compatibility shim to make Devise robust against legacy or invalid
# bcrypt hashes that otherwise raise BCrypt::Errors::InvalidHash.
#
# In this upgraded app, some code paths (e.g. uniqueness checks or
# Devise internals) may still try to compare a plaintext password with
# an existing `encrypted_password` value that isn't a valid bcrypt
# string (such as an empty string). By default, Devise delegates to
# BCrypt::Password.new, which raises `BCrypt::Errors::InvalidHash` and
# crashes the request.
#
# Here we reopen Devise::Encryptor#compare and rescue that exception,
# treating any invalid hash as a simple "password does not match".
if defined?(Devise) && defined?(Devise::Encryptor)
    module Devise
      module Encryptor
        class << self
          alias_method :compare_without_invalid_hash_rescue, :compare
  
          def compare(klass, hashed_password, password)
            compare_without_invalid_hash_rescue(klass, hashed_password, password)
          rescue BCrypt::Errors::InvalidHash
            false   # treat any invalid hash as "password does not match"
          end
        end
      end
    end
  end


